{ pkgSrc ? { outPath = ./.; name = "source"; }
, pkgs ? import <nixpkgs> {}
}:

let
  python = import ./requirements.nix { inherit pkgs; };
  version = pkgs.lib.removeSuffix "\n" (builtins.readFile ./VERSION);
in python.mkDerivation {
  name = "buildtools-${version}";
  src = pkgSrc;
  buildInputs = [
    python.pkgs."IPy"
    python.pkgs."WebOb"
    python.pkgs."coverage"
    python.pkgs."gevent"
    python.pkgs."mock"
    python.pkgs."nose"
    python.pkgs."pep8"
    python.pkgs."rednose"
  ];
  propagatedBuildInputs = [
    python.pkgs."Jinja2"
    python.pkgs."SQLAlchemy"
    python.pkgs."Twisted"
    python.pkgs."docopt"
    python.pkgs."furl"
    python.pkgs."python-dateutil"
    python.pkgs."redo"
    python.pkgs."requests"
    python.pkgs."simplejson"
  ] ++ (builtins.attrValues python.modules);
  checkPhase = ''
    export PYTHONPATH=./lib/python:./lib/python/vendor/poster-0.8.1:./lib/python/vendor:./sut_tools:$PYTHONPATH
    export HGRCPATH=./lib/python/mozilla_buildtools/test/hgrc

    coverage erase
    coverage run --branch --source ./lib/python nosetests -v --with-xunit --rednose --force-color ./lib/python
  '';
  postShellHook = ''
    export PYTHONDONTWRITEBYTECODE=1
    export PYTHONPATH=./vendor/lib/python:$PYTHONPATH
  '';
  passthru.python = python;
}
