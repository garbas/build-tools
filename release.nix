{ pkgSrc ? { outPath = ./.; name = "release"; }
, supportedSystems ? [ "x86_64-linux" ]
}:

let
  pkgs = import <nixpkgs> {};

  name = "balrog";
  version = pkgs.lib.removeSuffix "\n" (builtins.readFile ./version.txt);

  inDocker = config: buildPkg: system:
    let
      dockerImage = pkgs.dockerTools.buildImage {
        name = "docker-${name}-${version}";
        tag = version;
        fromImage = null;
        contents = with pkgs; [ busybox (buildPkg system) ];
        inherit config;
      };
    in pkgs.runCommand "docker-${name}-${version}" {} ''
      mkdir -p $out/nix-support
      ln -s ${dockerImage} $out/docker.tar.gz
      echo "file binary-dist $out/docker.tar.gz" > $out/nix-support/hydra-build-products
    '';

  forEach= systems: f:
    builtins.listToAttrs (map (system:
      { name = system;
        value = pkgs.lib.hydraJob (f system);
      }) systems);

  buildPkg = system:
    import ./default.nix {
      inherit pkgSrc;
      pkgs = import pkgs.path { inherit system; };
    };

  jobs = {

    tarball = pkgs.runCommand "${name}-${version}-tarball"
      { buildInputs = with pkgs.pythonPackages; [ python setuptools ]; }
      ''
        python ${name}/setup.py sdist --formats=gztar

        mkdir -p $out
        mv dist/${name}-${version}.tar.gz $out/

        mkdir -p $out/nix-support
        echo "file source-dist $out/${name}-${version}.tar.gz" > $out/nix-support/hydra-build-products
      '';

    build = forEach supportedSystems buildPkg;
    docker = forEach supportedSystems (inDocker {} buildPkg);

    release = pkgs.releaseTools.aggregate {
      name = "${name}-${version}";
      meta.description = "Aggregate job containing the release-critical jobs.";
      constituents = [ jobs.tarball ] ++
        (map (x: builtins.attrValues x) (with jobs; [ build docker ]));
    };

  };

in jobs
