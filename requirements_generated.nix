# generated using pypi2nix tool (version: 1.2.0)
#
# COMMAND:
#   pypi2nix -r requirements.txt -V 2.7 -E libevent
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "IPy" = python.mkDerivation {
    name = "IPy-0.81";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/08/c0/8dde3aa805abdaff91a4a06c3cdc1f789547af80750560211d7cf442e1b7/IPy-0.81.tar.gz";
      md5= "7a305c0b60950a9a90c89e9a6f9e06f4";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "BSD License";
      description = "Class and tools for handling of IPv4 and IPv6 addresses and networks";
    };
  };



  "Jinja2" = python.mkDerivation {
    name = "Jinja2-2.8";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f2/2f/0b98b06a345a761bec91a079ccae392d282690c2d8272e708f4d10829e22/Jinja2-2.8.tar.gz";
      md5= "edb51693fe22c53cee5403775c71a99e";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."MarkupSafe"
  ];
    meta = {
      homepage = "";
      license = "BSD";
      description = "A small but fast and easy to use stand-alone template engine written in pure python.";
    };
  };



  "MarkupSafe" = python.mkDerivation {
    name = "MarkupSafe-0.23";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz";
      md5= "f5ab3deee4c37cd6a922fb81e730da6e";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "BSD";
      description = "Implements a XML/HTML/XHTML Markup safe string for Python";
    };
  };



  "SQLAlchemy" = python.mkDerivation {
    name = "SQLAlchemy-1.0.13";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/1d/e2/3df2e0e8cd3cf7e6e2905f1a3d44f1ba51c4fceab0968cc0cb3dcefcb53a/SQLAlchemy-1.0.13.tar.gz";
      md5= "cef0c4aa0e2464a6f903a9cac9b280d8";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "MIT License";
      description = "Database Abstraction Library";
    };
  };



  "Twisted" = python.mkDerivation {
    name = "Twisted-10.1.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/00/ea/6e50396d390aedf4af6e5ceff74a8885ae0bae741c5e22f72e5ec19832ff/Twisted-10.1.0.tar.bz2";
      md5= "04cca97506e830074cffc1965297da3f";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."zope.interface"
  ];
    meta = {
      homepage = "";
      license = "lib.mit";
      description = "An asynchronous networking framework written in Python";
    };
  };



  "WebOb" = python.mkDerivation {
    name = "WebOb-1.2.3";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/6c/b0/9012df5d40a15fdfa9c233580b8b555b943b8797ce588aa6ce90390c6f7b/WebOb-1.2.3.tar.gz";
      md5= "11825b7074ba7043e157805e4e6e0f55";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."coverage"
    self."nose"
  ];
    meta = {
      homepage = "";
      license = "lib.mit";
      description = "WSGI request and response object";
    };
  };



  "coverage" = python.mkDerivation {
    name = "coverage-3.6";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/d2/2d/e15d38b0a34a3e88e3c164a7ec04ed43f45869c20304db13875b24002506/coverage-3.6.tar.gz";
      md5= "67d4e393f4c6a5ffc18605409d2aa1ac";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "BSD";
      description = "Code coverage measurement for Python";
    };
  };



  "docopt" = python.mkDerivation {
    name = "docopt-0.6.2";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz";
      md5= "4bc74561b37fad5d3e7d037f82a4c3b1";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "lib.mit";
      description = "Pythonic argument parser, that will make you smile";
    };
  };



  "furl" = python.mkDerivation {
    name = "furl-0.5.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/5f/8b/c5969170eb284a553fadfe6c53a14859d558ae818fd41aaddd07de3fe255/furl-0.5.1.tar.gz";
      md5= "d36e73d8cc92c2235e5f983b0c3a8554";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."orderedmultidict"
    self."six"
  ];
    meta = {
      homepage = "";
      license = "Unlicense";
      description = "URL manipulation made simple.";
    };
  };



  "gevent" = python.mkDerivation {
    name = "gevent-0.13.8";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/73/1b/513d05b856c32565fea7cd02c10c9deb09aee4d4969ca57e3e86ae12055e/gevent-0.13.8.tar.gz";
      md5= "ca9dcaa7880762d8ebbc266b11252960";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."greenlet"
  ];
    meta = {
      homepage = "";
      license = "";
      description = "Python network library that uses greenlet and libevent for easy and scalable concurrency";
    };
  };



  "greenlet" = python.mkDerivation {
    name = "greenlet-0.4.10";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/67/62/ca2a95648666eaa2ffeb6a9b3964f21d419ae27f82f2e66b53da5b943fc4/greenlet-0.4.10.zip";
      md5= "bed0c4b3b896702131f4d5c72f87c41d";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "MIT License";
      description = "Lightweight in-process concurrent programming";
    };
  };



  "mock" = python.mkDerivation {
    name = "mock-1.0.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/15/45/30273ee91feb60dabb8fbb2da7868520525f02cf910279b3047182feed80/mock-1.0.1.zip";
      md5= "869f08d003c289a97c1a6610faf5e913";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "";
      description = "A Python Mocking and Patching Library for Testing";
    };
  };



  "nose" = python.mkDerivation {
    name = "nose-1.3.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/de/f4/b205776cf5cbddbc1e2c3223fa29c0d05f18a9b8afad8cfa23438c217434/nose-1.3.0.tar.gz";
      md5= "95d6d32b9d6b029c3c65674bd9e7eabe";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "GNU LGPL";
      description = "nose extends unittest to make testing easier";
    };
  };



  "orderedmultidict" = python.mkDerivation {
    name = "orderedmultidict-0.7.6";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/9d/81/19692d8969035147c96b29de97a71a7f8dda89cd84290de42ce2d6042b82/orderedmultidict-0.7.6.tar.gz";
      md5= "39a2dafbb43c2e8e4aa0a4219464bc27";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."six"
  ];
    meta = {
      homepage = "";
      license = "Unlicense";
      description = "Ordered Multivalue Dictionary - omdict.";
    };
  };



  "pep8" = python.mkDerivation {
    name = "pep8-1.4.3";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/2a/cd/4f5a3c0ff7afff389bee4faea0904cbd6eda0acdfee3af8faf5471137508/pep8-1.4.3.tar.gz";
      md5= "6dc6ffbebda6cadbad4c789933dd0d23";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "Expat license";
      description = "Python style guide checker";
    };
  };



  "python-dateutil" = python.mkDerivation {
    name = "python-dateutil-2.5.3";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/3e/f5/aad82824b369332a676a90a8c0d1e608b17e740bbb6aeeebca726f17b902/python-dateutil-2.5.3.tar.gz";
      md5= "05ffc6d2cc85a7fd93bb245807f715ef";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."six"
  ];
    meta = {
      homepage = "";
      license = "Simplified BSD";
      description = "Extensions to the standard Python datetime module";
    };
  };



  "python-termstyle" = python.mkDerivation {
    name = "python-termstyle-0.1.10";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/b3/b0/97086bb087d660cbdb9c0b0dbaa0548ebd9ba9d5e4701bc09b862228110d/python-termstyle-0.1.10.tar.gz";
      md5= "1b227cebbeda209029252420af72e5c7";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "BSD";
      description = "console colouring for python";
    };
  };



  "rednose" = python.mkDerivation {
    name = "rednose-0.4.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/39/f0/5c67c8582716bfe6b7a0f344fe837be9004b0b23b2b15dd279c72d7f3274/rednose-0.4.1.tar.gz";
      md5= "8f5705c22a7f898ded65dd7b64c1f6de";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."python-termstyle"
  ];
    meta = {
      homepage = "";
      license = "BSD";
      description = "coloured output for nosetests";
    };
  };



  "redo" = python.mkDerivation {
    name = "redo-1.5";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/78/e0/5d0e71638caee3cfff369520bbdf7b1145c498aa5d36855fed5881560827/redo-1.5.tar.gz";
      md5= "a18057787e969ee6aa7ccd88e5090762";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "";
      description = "Utilities to retry Python callables.";
    };
  };



  "requests" = python.mkDerivation {
    name = "requests-2.10.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/49/6f/183063f01aae1e025cf0130772b55848750a2f3a89bfa11b385b35d7329d/requests-2.10.0.tar.gz";
      md5= "a36f7a64600f1bfec4d55ae021d232ae";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "lib.asl20";
      description = "Python HTTP for Humans.";
    };
  };



  "simplejson" = python.mkDerivation {
    name = "simplejson-3.8.2";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f0/07/26b519e6ebb03c2a74989f7571e6ae6b82e9d7d81b8de6fcdbfc643c7b58/simplejson-3.8.2.tar.gz";
      md5= "53b1371bbf883b129a12d594a97e9a18";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "MIT License";
      description = "Simple, fast, extensible JSON encoder/decoder for Python";
    };
  };



  "six" = python.mkDerivation {
    name = "six-1.10.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz";
      md5= "34eed507548117b2ab523ab14b2f8b55";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "lib.mit";
      description = "Python 2 and 3 compatibility utilities";
    };
  };



  "virtualenv" = python.mkDerivation {
    name = "virtualenv-13.1.2";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/41/96/8d1d3f0f160512d637c1aeaeddf4039525ee0eb17cf5be0c1eca7de6bd76/virtualenv-13.1.2.tar.gz";
      md5= "b989598f068d64b32dead530eb25589a";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = {
      homepage = "";
      license = "lib.mit";
      description = "Virtual Python Environment builder";
    };
  };



  "zope.interface" = python.mkDerivation {
    name = "zope.interface-4.2.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/ea/a3/38bdc8e8bd068ea5b4d21a2d80eca1547cd8509318e8d7c875f7247abe43/zope.interface-4.2.0.tar.gz";
      md5= "2950a6db7e985e19c7a846cc20f5d82a";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
    self."coverage"
    self."nose"
  ];
    meta = {
      homepage = "";
      license = "lib.zpt21";
      description = "Interfaces for Python";
    };
  };

}