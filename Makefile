install: vim bash zsh git javascript python ruby scite

initmodules: 
	git submodule init
	git submodule update

bash:
	echo ". "`pwd`/.bashrc >> ~/.bashrc

zsh: initmodules
	sudo apt-get install zsh
	chsh -s /bin/zsh
	zsh prezto_installer.zsh

git:
	sudo apt-get install git
	test -e ~/.gitconfig && mv ~/.gitconfig ~/.gitconfig_bak
	ln -s `pwd`/.gitconfig ~/.gitconfig

vim:
	sudo apt-get install vim-gnome
	test -e ~/.vim && mv ~/.vim ~/.vim_bak
	ln -s `pwd`/.vim ~/.vim
	test -e ~/.vimrc && mv ~/.vimrc ~/.vimrc_bak
	ln -s `pwd`/.vimrc ~/.vimrc

dpkg:
	sudo apt-get install curl

node: initmodules dpkg
	ln -s `pwd`/.nvm ~/.nvm
	. ~/.nvm/nvm.sh
	nvm install 0.8.16
	nvm alias default 0.8

javascript: node
	npm install jshint -g

php:
	sudo pear install PHP_CodeSniffer
	sudo pear channel-discover pear.phpmd.org
	sudo pear channel-discover pear.pdepend.org
	sudo pear install --alldeps phpmd/PHP_PMD

python:
	test -e ~/.pythonrc && mv ~/.pythonrc ~/.pythonrc_bak
	ln -s `pwd`/.pythonrc ~/.pythonrc

ruby:
	test -e ~/.irbrc && mv ~/.irbrc ~/.irbrc_bak
	ln -s `pwd`/.irbrc ~/.irbrc

scite:
	test -e ~/.SciTEUser.properties && mv ~/.SciTEUser.properties ~/.SciTEUser.properties_bak
	ln -s `pwd`/.SciTEUser.properties ~/.SciTEUser.properties