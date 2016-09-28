# generated using pypi2nix tool (version: 1.2.0)
#
# COMMAND:
#   pypi2nix -r requirements.txt -V 2.7 -E libevent
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages = pkgs.python27Packages;
  commonBuildInputs = with pkgs; [ libevent ];
  commonDoCheck = false;

  buildEnv = { pkgs ? {}, modules ? {} }:
    let
      interpreter = pythonPackages.python.buildEnv.override {
        extraLibs = (builtins.attrValues pkgs) ++ (builtins.attrValues modules);
      };
    in {
      mkDerivation = pythonPackages.buildPythonPackage;
      interpreter = if inNixShell then interpreter.env else interpreter;
      overrideDerivation = drv: f: pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs);
      inherit buildEnv pkgs modules;
    };

  generated = import ./requirements_generated.nix { inherit pkgs python commonBuildInputs commonDoCheck; };
  overrides = import ./requirements_override.nix { inherit pkgs python; };

  python = buildEnv {
    pkgs = fix' (extends overrides generated);
  };

in python