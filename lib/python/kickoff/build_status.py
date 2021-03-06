from datetime import datetime, timedelta
from dateutil import parser, tz
from taskcluster.exceptions import TaskclusterRestFailure

from kickoff import task_for_revision

import logging
log = logging.getLogger(__name__)


_BUILD_WATCHERS = {}


# TODO: Bug 1300147. Avoid having 7 parameters by using a release object that contains only what's needed.
def are_en_us_builds_completed(index, release_name, submitted_at, branch, revision, tc_product_name, platforms):
    try:
        watcher = _BUILD_WATCHERS[release_name]
    except KeyError:
        watcher = EnUsBuildsWatcher(index, release_name, submitted_at, branch, revision, tc_product_name, platforms)
        _BUILD_WATCHERS[release_name] = watcher
        log.debug('New watcher created for "%s"', release_name)

    result = watcher.are_builds_completed()

    if result is True:
        del _BUILD_WATCHERS[release_name]
        log.debug('Builds for "%s" are completed. Watcher deleted', release_name)

    return result


class LoggedError(Exception):
    def __init__(self, message):
        log.exception(message)
        Exception.__init__(self, message)


class EnUsBuildsWatcher:
    # TODO: Bug 1300147 as well
    def __init__(self, index, release_name, submitted_at, branch, revision, tc_product_name, platforms):
        self.taskcluster_index = index
        self.taskcluster_product_name = tc_product_name

        self.release_name = release_name
        self.branch = branch
        self.revision = revision
        self.task_per_platform = {p: None for p in platforms}

        self._timeout_watcher = TimeoutWatcher(start_timestamp=submitted_at)

    def are_builds_completed(self):
        if self._timeout_watcher.timed_out:
            raise TimeoutWatcher.TimeoutError(self.release_name, self._timeout_watcher.start_timestamp)

        self._fetch_completed_tasks()

        return len(self._platforms_with_no_task) == 0

    def _fetch_completed_tasks(self):
        platforms_with_no_task = self._platforms_with_no_task
        log.debug('Release "%s" still has to find tasks for %s', self.release_name, platforms_with_no_task)

        for platform in platforms_with_no_task:
            try:
                # Tasks are always completed if they are referenced in the index
                # https://docs.taskcluster.net/reference/core/index
                task_id = task_for_revision(
                    self.taskcluster_index, self.branch, self.revision, self.taskcluster_product_name, platform
                )['taskId']
            except TaskclusterRestFailure:
                log.debug('Task for platform "%s" is not yet created for release "%s"', platform, self.release_name)
                continue

            log.debug('Task "%s" was found for release "%s" and platform "%s"', task_id, self.release_name, platform)
            self.task_per_platform[platform] = task_id

    @property
    def _platforms_with_no_task(self):
        return [platform for platform, task in self.task_per_platform.iteritems() if task is None]


class TimeoutWatcher:
    MAX_WAITING_TIME = timedelta(days=1)

    def __init__(self, start_timestamp):
        self.start_timestamp = parser.parse(start_timestamp)

    @staticmethod
    def _now():
        # Can't use utcnow(), because dateutil gives offset-aware datetimes
        return datetime.now(tz.tzutc())

    @property
    def timed_out(self):
        return self._now() - self.start_timestamp >= self.MAX_WAITING_TIME

    class TimeoutError(LoggedError):
        def __init__(self, release_name, start_timestamp):
            LoggedError.__init__(
                self,
                '{} has spent more than {} between the release being submitted on ship-it (at {} [UTC]) and now.'
                .format(release_name, TimeoutWatcher.MAX_WAITING_TIME, start_timestamp)
            )

    class AlreadyStartedError(Exception):
        # Common error, there's no need to log it.
        pass
