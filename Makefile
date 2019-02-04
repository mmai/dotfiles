initmodules: 
	# install .zsh/zplug
	git submodule init
	git submodule update

install: initmodules
	spark deploy spark.sus
	cat dconf-henri.ini | dconf load /
