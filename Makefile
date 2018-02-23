install: bash zsh git python ruby vim

initmodules: 
	git submodule init
	git submodule update

termite:
	sh termite.sh
	ln -s `pwd`/.config/termite ~/.config

xmonad:
	ln -s `pwd`/.xmonad/xmonad.hs ~/.xmonad/

bash:
	echo ". "`pwd`/.bashrc >> ~/.bashrc

zsh: initmodules
	sudo apt-get install zsh
	chsh -s /bin/zsh
	ln -s `pwd`/.zsh ~/.zsh
	ln -s `pwd`/.zshrc ~/.zshrc

git:
	sudo apt-get install git
	-test -e ~/.gitconfig && mv ~/.gitconfig ~/.gitconfig_bak
	-test -e ~/.gitignore_global && mv ~/.gitignore_global ~/.gitignore_global_bak
	ln -s `pwd`/.gitignore_global ~/.gitignore_global

vim: fonts languagetool
	sudo apt-get install vim-gnome ctags
	ln -s `pwd`/.vim ~/.vim
	#Powerline
	sudo apt-get install python-fontforge
	#Command-T
	cd .vim/bundle/Command-T/ruby/command-t;ruby extconf.rb;make;cd ~/dotfiles
	#Haskell support
	cd ~/.vim/haskell-vim-now/bin/;sh ./install.sh;cd -

fonts:
	# ln -s `pwd`/.fonts ~/.fonts
	# fc-cache -vf ~/.fonts
	git clone https://github.com/ryanoasis/nerd-fonts /tmp/nerd-fonts
	cd /tmp/nerd-fonts
	./install.sh Cousine
	./install.sh DejaVuSansMono

languagetool:
	cd /usr/local/
	sudo wget http://www.languagetool.org/download/LanguageTool-2.0.zip
	sudo unzip LanguageTool-2.0.zip; rm LanguageTool-2.0.zip

dpkg:
	sudo apt install curl silversearcher-ag aptitude tig tree taskwarrior ncdu

javascript: node
	npm install jshint -g

php:
	sudo pear install PHP_CodeSniffer
	sudo pear channel-discover pear.phpmd.org
	sudo pear channel-discover pear.pdepend.org
	sudo pear install --alldeps phpmd/PHP_PMD

python:
	-test -e ~/.pythonrc && mv ~/.pythonrc ~/.pythonrc_bak
	sudo apt-get install python-pip
	ln -s `pwd`/.pythonrc ~/.pythonrc
	sudo pip install virtualenv virtualenvwrapper pep8 autopep8 pyflakes flake8

ruby:
	sudo apt-get install ruby ruby-dev
	-test -e ~/.irbrc && mv ~/.irbrc ~/.irbrc_bak
	ln -s `pwd`/.irbrc ~/.irbrc

haskell:
	curl -sSL https://get.haskellstack.org/ | sh

gnome:
	echo "ALT TAB change windows on current workspace only"
	gsettings set org.gnome.shell.app-switcher current-workspace-only true
