install: vim bash zsh git python ruby scite

initmodules: 
	git submodule init
	git submodule update

vim:
	test -e ~/.vim && mv ~/.vim ~/.vim_bak
	ln -s `pwd`/.vim ~/.vim
	test -e ~/.vimrc && mv ~/.vimrc ~/.vimrc_bak
	ln -s `pwd`/.vimrc ~/.vimrc

bash:
	echo ". "`pwd`/.bashrc >> ~/.bashrc

zsh: initmodules
	sudo apt-get install zsh
	chsh -s /bin/zsh
	zsh prezto_installer.zsh

git:
	test -e ~/.gitconfig && mv ~/.gitconfig ~/.gitconfig_bak
	ln -s `pwd`/.gitconfig ~/.gitconfig

python:
	test -e ~/.pythonrc && mv ~/.pythonrc ~/.pythonrc_bak
	ln -s `pwd`/.pythonrc ~/.pythonrc

ruby:
	test -e ~/.irbrc && mv ~/.irbrc ~/.irbrc_bak
	ln -s `pwd`/.irbrc ~/.irbrc

scite:
	test -e ~/.SciTEUser.properties && mv ~/.SciTEUser.properties ~/.SciTEUser.properties_bak
	ln -s `pwd`/.SciTEUser.properties ~/.SciTEUser.properties
