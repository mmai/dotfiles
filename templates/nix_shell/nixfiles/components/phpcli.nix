{ pkgs, cfg }:

let
  phpIni = (import ./phpini.nix) {inherit pkgs ;};
in
{
  buildInputs = with pkgs; [ php ];

  shellInit = ''
    export COMPOSER_MEMORY_LIMIT=-1
    export PHP_INI=${phpIni}
    alias php="${pkgs.php}/bin/php -c ${phpIni}"
    '';

  shellStartService = ''
  '';

  shellStopService = ''
  '';

  shellDump = ''
  '';

  shellRestore = ''
  '';
}
