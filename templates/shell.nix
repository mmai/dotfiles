# Create ./nix repository with `niv init`
# see `niv --help` for showing, updating, changing pinned channels

{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {}
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.htop
  ];

  shellHook = ''
    echo hello $MY_ENVIRONMENT_VARIABLE
  '';

  MY_ENVIRONMENT_VARIABLE = "world";
}
