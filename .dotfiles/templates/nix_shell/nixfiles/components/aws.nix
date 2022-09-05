{ pkgs }:

{
  buildInputs = (with pkgs; [ python3 awscli2 ]);
    
  # awsebcli package marked as broken in NixOS 21.05, we install it manually
  shellInit = ''
    python3 -m venv .venv
    source .venv/bin/activate
    test -e .venv/bin/eb || pip install awsebcli
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
