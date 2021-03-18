{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  cfg =
    if builtins.pathExists ./config.nix
    then import ./config.nix
    else {  # default configuration
      psqlPort = "5432";
      psqlPassword = "postgres";
    };
  rootDir   = toString ./.;
  # psqlDir  = "${rootDir}/psql";
in

mkShell {
  buildInputs = [
    # php php74Packages.composer2 postgresql
  ];

  shellHook = ''
    # set -o allexport; source .env; source .env.local set +o allexport

    ROOT=$(pwd)/nixfiles

    function startServices {
      echo "hello from $ROOT"
    }

    startServices
  '';
}
