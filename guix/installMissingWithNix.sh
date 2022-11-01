#!/usr/bin/env bash

USER=henri

init(){
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable
  nix-channel --update
  # ln -s "/nix/var/nix/profiles/per-user/$USER/profile" ~/.nix-profile
  # source /run/current-system/profile/etc/profile.d/nix.sh
}

nix-env -i lazygit dbeaver

