{ pkgs, cfg }:

{
  buildInputs = with pkgs; [
    rustc cargo cargo-edit
    pkgconfig openssl
  ];

  shellInit = ''
    export RUST_BACKTRACE=1
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
