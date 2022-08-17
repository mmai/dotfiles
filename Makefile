initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

nnn:
	# install nnn plugins
	curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh

install: initmodules nnn
	spark deploy spark.sus
	git clone git@github.com:mmai/ThinkVim.git ~/.config/ThinkVim
	ln -s ~/.config/ThinkVim ~/.config/nvim
	cat dconf-henri.ini | dconf load /


dumpconf:
	dconf dump / 
