installdeps:
	bash ./installdeps.sh
nnn:
	# install nnn plugins
	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

guix:
	ln -s ~/dotfiles/guix/config.scm /etc/config.scm
	ln -s ~/dotfiles/guix/nonguix-signing-key.pub /etc/nonguix-signing-key.pub

dconf:
	cat dconf-henri.ini | dconf load /

dumpconf:
	dconf dump / 
