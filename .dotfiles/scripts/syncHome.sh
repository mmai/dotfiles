#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

setup_colors

# script logic here

store() {

}

restore() {

}

# msg "${BLUE}Cloning dotfiles${NOFORMAT}"
# cd ~
# git clone git@github.com:mmai/dotfiles.git

msg "${BLUE}Installing zinit & linking zsh config${NOFORMAT}"
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
ln -s ~/dotfiles/.zsh ~/.zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh

msg "${BLUE}Linking dotfiles${NOFORMAT}"
mkdir -p ~/.config/alacritty
ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/dotfiles/.config/kahl ~/.config/khal
ln -s ~/dotfiles/.config/kard ~/.config/khard
ln -s ~/dotfiles/.config/neomutt/ ~/.config/neomutt
ln -s ~/dotfiles/.config/nvim/ ~/.config/nvim
ln -s ~/dotfiles/.config/surfraw/ ~/.config/surfraw
ln -s ~/dotfiles/.tmuxp ~/.tmuxp
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.mbsyncrc ~/.mbsyncrc
ln -s ~/dotfiles/.msmtprc ~/.msmtprc
cd ~/.local

msg "${BLUE}Home secrets${NOFORMAT}"
FILES=".cert .config/cachix .ssh .password-store .aws"

msg "${BLUE}Home data${NOFORMAT}"
# evolution...
# .config/MusicBrainz
# Documents
# Images
# Musique
# nixos-config // git
# OpenVpn
# qmk_firmware
# softs_
# think // git
# Téléchargements ?
# vpnAtixnet.sh
# vpnRatpdev.sh

msg "${BLUE}Custom softs${NOFORMAT}"

msg "${BLUE}Work projects${NOFORMAT}"
# travaux
msg "${BLUE}Work datas${NOFORMAT}"
