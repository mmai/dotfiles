{ pkgs ? import <nixpkgs> { } }:
with pkgs;

let
  assembleComponents = ( components: {
    buildInputs = map (c: c.buildInputs) components;
    shellInit = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellInit) components);
    shellStartService = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellStartService) components);
    shellStopService = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellStopService) components);
    shellDump = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellDump) components);
    shellRestore = builtins.foldl' (a: b: a + b ) "" (map (c: c.shellRestore) components);
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
      mysql = {
        port = "3307";
        password = "mypassword";
        databases = [ "mydb" ];
      };
      phpfpm = {};
      nginx = {};
    };

  components = assembleComponents [ 
    # ((import ./components/mysql.nix) { inherit pkgs; cfg = cfg.mysql; })
    ((import ./components/postgresql.nix) { inherit pkgs; cfg = cfg.postgresql; })
    ((import ./components/phpfpm.nix) { inherit pkgs; cfg = cfg.phpfpm; })
    ((import ./components/phpcli.nix) { inherit pkgs; cfg = cfg.phpcli; })
    # ((import ./components/aws.nix) { inherit pkgs })
    # ((import ./components/nginx.nix) { inherit pkgs; cfg = cfg.nginx; })
  ];

  rootDir   = toString ./.;
in

mkShell {
  buildInputs = [
    compass.out
    # nodePackages.gulp
    # zlib # needed by optipng
  ] ++ components.buildInputs;

  shellHook = ''
    # set -a # automatically export all variables
    # source .env
    # set +a

    # set -o allexport; source .env; source .env.local set +o allexport
    ROOT=$(pwd)/nixfiles
    ROOT_VAR=$ROOT/var
    ROOT_DUMP=$ROOT/dump

    ${components.shellInit}

    function startServices {
      echo "*** STARTING SERVICES ***"
      ${components.shellStartService}
    }

    function stopServices {
      echo "*** SHUTDOWN SERVICES ***"
      ${components.shellStopService}
    }

    function dumpServices {
      echo "*** Dump ***"
      ${components.shellDump}
    }

    function restoreServices {
      echo "*** Restore ***"
      ${components.shellRestore}
    }

    LIGHTBULB='\xF0\x9F\x92\xA1'
    YELLOW='\033[1;33m'
    RESET='\033[0m'

    echo -e "$YELLOW$LIGHTBULB$RESET Start services with $YELLOW'startServices' $RESET"
    echo -e "$YELLOW$LIGHTBULB$RESET Stop services with $YELLOW'stopServices' $RESET"
    echo -e "$YELLOW$LIGHTBULB$RESET Dump state data with $YELLOW'dumpServices' $RESET"
    echo -e "$YELLOW$LIGHTBULB$RESET Restore state data with $YELLOW'restoreServices' $RESET"
  '';
}
