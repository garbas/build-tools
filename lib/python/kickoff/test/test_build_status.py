import unittest
from mock import MagicMock, patch
import taskcluster
from datetime import datetime, timedelta
from dateutil import tz

from kickoff.build_status import are_en_us_builds_completed, EnUsBuildsWatcher, TimeoutWatcher


class BuildsCompletedBase(unittest.TestCase):
    def setUp(self):
        self.index = MagicMock()
        self.branch = 'mozilla-release'
        self.revision = 'abcdef123456'
        self.tc_product_name = 'firefox'
        self.platforms = ('linux', 'win32', 'win64')

        self.now = datetime.now(tz.tzutc())
        self.submitted_at = '{}+00:00'.format(self.now.isoformat())


class AreEnUsBuildsCompletedTest(BuildsCompletedBase):
    # Each test in this suite defines a different release_name. That's because
    # tests are multi-threaded and there are collisions with the internal of
    # memoization of are_en_us_builds_completed()

    def test_returns_true_when_everything_is_ready(self):
        self.index.findTask.side_effect = SideEffects.everything_has_an_id

        release_name = 'Firefox-32.0b1-build1'
        self.assertTrue(are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        ))

    def test_returns_false_if_one_task_is_missing(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task

        release_name = 'Firefox-32.0b1-build2'
        self.assertFalse(are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        ))

    def test_stores_results_of_the_previous_call(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task

        release_name = 'Firefox-32.0b1-build5'
        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms))

        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms) + 1)

    def test_creates_new_watcher_if_new_release_name(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task

        release_name = 'Firefox-32.0b1-build6'
        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms))

        release_name = 'Firefox-32.0b1-build99'
        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms) * 2)

    def test_delete_watcher_if_all_builds_are_completed(self):
        self.index.findTask.side_effect = SideEffects.everything_has_an_id

        release_name = 'Firefox-32.0b1-build7'
        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms))

        are_en_us_builds_completed(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )
        self.assertEqual(self.index.findTask.call_count, len(self.platforms) * 2)


class EnUsBuildsWatcherTest(BuildsCompletedBase):
    def setUp(self):
        BuildsCompletedBase.setUp(self)
        release_name = 'Firefox-46.0b8-build1'
        self.watcher = EnUsBuildsWatcher(
            self.index, release_name, self.submitted_at, self.branch,
            self.revision, self.tc_product_name, self.platforms
        )

    def test_returns_true_when_everything_is_ready(self):
        self.index.findTask.side_effect = SideEffects.everything_has_an_id
        self.assertTrue(self.watcher.are_builds_completed())

    def test_returns_false_if_one_task_is_missing(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task
        self.assertFalse(self.watcher.are_builds_completed())

    def test_only_fetches_missing_tasks_the_second_time(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task

        self.watcher.are_builds_completed()
        self.assertEqual(self.index.findTask.call_count, len(self.platforms))

        self.watcher.are_builds_completed()
        self.assertEqual(self.index.findTask.call_count, len(self.platforms) + 1)

    def test_times_out_1_day_after_submission_in_ship_it(self):
        self.index.findTask.side_effect = SideEffects.linux_has_no_task

        less_than_one_day_after_submission = self.now + timedelta(hours=23, minutes=59, seconds=59)
        with patch('kickoff.build_status.TimeoutWatcher._now', return_value=less_than_one_day_after_submission):
            self.watcher.are_builds_completed()

        one_day_after_submission = self.now + timedelta(days=1, seconds=1)
        with patch('kickoff.build_status.TimeoutWatcher._now', return_value=one_day_after_submission):
            with self.assertRaises(TimeoutWatcher.TimeoutError):
                self.watcher.are_builds_completed()


class SideEffects:
    @staticmethod
    def everything_has_an_id(_):
        return {'taskId': 'anId'}

    @staticmethod
    def linux_has_no_task(namespace):
        if 'linux' in namespace:
            raise taskcluster.exceptions.TaskclusterRestFailure('place', 'hold', 'ers')
        return {'taskId': 'anId'}
