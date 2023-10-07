# Dotfiles

## Setup
```sh
git init --bare $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles remote add origin git@github.com:mmai/dotfiles.git
```

## Replication
```sh
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/mmai/dotfiles.git dotfiles-tmp
rsync --recursive --backup-dir=$HOME/dotfiles_originals_backup  --exclude '.git' dotfiles-tmp/ $HOME/
rm -rf dotfiles-tmp
# edit personal infos in ~/.gitconfig
```

## Configuration
```sh
dotfiles config status.showUntrackedFiles no
dotfiles remote set-url origin git@github.com:mmai/dotfiles.git
```

## Usage
```sh
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m 'Add gitconfig'
dotfiles push
```
