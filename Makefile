install: vim bash oh-my-zsh git python ruby scite

vim:
	test -e ~/.vim && mv ~/.vim ~/.vim_bak
	ln -s `pwd`/.vim ~/.vim
	test -e ~/.vimrc && mv ~/.vimrc ~/.vimrc_bak
	ln -s `pwd`/.vimrc ~/.vimrc

bash:
	echo ". "`pwd`/.bashrc >> ~/.bashrc

oh-my-zsh:
	ln -s `pwd`/.oh-my-zsh/custom/ask_when_overwrite.zsh ~/.oh-my-zsh/custom/ask_when_overwrite.zsh
	ln -s `pwd`/.oh-my-zsh/custom/shortcuts.zsh ~/.oh-my-zsh/custom/shortcuts.zsh

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
