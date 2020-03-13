initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

install: initmodules
	spark deploy spark.sus
	git clone git@github.com:mmai/ThinkVim.git ~/.config/ThinkVim
	ln -s ~/.config/ThinkVim ~/.config/nvim
	cat dconf-henri.ini | dconf load /

dumpconf:
	dconf dump / 
