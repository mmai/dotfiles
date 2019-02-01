initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

install: initmodules
	spark deploy spark.sus
	dconf load dconf-henri.ini
