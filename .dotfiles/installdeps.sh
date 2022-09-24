GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
RESET='\033[0m'

CHECK='\xE2\x9C\x94'
CROSS='\xE2\x9D\x8C'
GEAR='\xE2\x9A\x99'

checkInstall() {
  if ! command -v $1 &> /dev/null; then
    echo -e "${BLUE}$GEAR ...Installation de $1...${RESET}"
    nix-env -i $2
  fi
}

if ! command -v nix &> /dev/null; then
  echo -e "${RED}\xE2\x9D\x8C Nix non trouvé${RESET}"
  echo "Veuillez installer nix https://nixos.org/guides/install-nix.html"
  exit 1
else
  echo -e "${GREEN}$CHECK Nix est installé${RESET}"

  checkInstall "zsh" "zsh"
  checkInstall "tmux" "tmux"
  checkInstall "fzf" "fzf"
  checkInstall "exa" "exa"
  checkInstall "nvim" "neovim"
  checkInstall "nnn" "nnn"
  checkInstall "direnv" "direnv"
fi
