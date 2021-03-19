{ pkgs, cfg }:

{
  buildInputs = with pkgs; [ php ];

  shellInit = ''
    echo "hello from phpfpm component"
    '';

  shellStartService = ''
  '';

  shellStopService = ''
  '';
}
