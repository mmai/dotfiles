initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

install: initmodules
	stark deploy stark.sus
	dconf load dconf-henri.ini
