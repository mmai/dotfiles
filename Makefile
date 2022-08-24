initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

nnn:
	# install nnn plugins
	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

homefiles:
	ln -s ~/dotfiles/.local/bin/ewrap.sh ~/.local/bin/ewrap.sh

guix:
	ln -s ~/dotfiles/.config/guix ~/.config/guix
	ln -s ~/dotfiles/guix/config.scm /etc/config.scm
	ln -s ~/dotfiles/guix/nonguix-signing-key.pub /etc/nonguix-signing-key.pub

install: initmodules nnn homefiles
	spark deploy spark.sus
	cat dconf-henri.ini | dconf load /


dumpconf:
	dconf dump / 
