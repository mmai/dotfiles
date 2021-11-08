{ pkgs }:

{
  buildInputs = (with pkgs; [ python3 awscli2 ]);
    
  shellInit = ''
    python3 -m venv .venv
    source .venv/bin/activate
    pip install awsebcli
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
