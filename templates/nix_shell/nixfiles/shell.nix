{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  assembleComponents = ( components: {
    buildInputs = map (c: c.buildInputs) components;
    shellInit = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellInit) components);
    shellStartService = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellStartService) components);
    shellStopService = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellStopService) components);
  } );

  cfg =
    if builtins.pathExists ./config.nix
    then import ./config.nix
    else {  # default configuration
      postgresql = {
        port = "5433";
        name = "mydb";
        user = "myuser";
        password = "mypassword";
      };
      phpfpm = {};
      nginx = {};
    };

  components = assembleComponents [ 
    ((import ./components/postgresql.nix) { inherit pkgs; cfg = cfg.postgresql; })
    ((import ./components/phpfpm.nix) { inherit pkgs; cfg = cfg.phpfpm; })
    # ((import ./components/nginx.nix) { inherit pkgs; cfg = cfg.nginx; })
  ];

  rootDir   = toString ./.;
in

mkShell {
  buildInputs = [
    # php php74Packages.composer2
  ] ++ components.buildInputs;

  shellHook = ''
    # set -o allexport; source .env; source .env.local set +o allexport
    ROOT=$(pwd)/nixfiles
    ROOT_VAR=$ROOT/var

    ${components.shellInit}

    function startServices {
      echo "*** STARTING SERVICES ***"
      ${components.shellStartService}
    }

    function stopServices {
      ${components.shellStopService}
    }
  '';
}
