export TERM="xterm-256color"

########################
# ZPlug plugins manager 
########################
export ZPLUG_HOME=$HOME/.zsh/zplug
source $ZPLUG_HOME/init.zsh

# Prezto plugins
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/command-not-found", from:prezto
zplug "modules/node", from:prezto
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' keymap 'vi'
zstyle ':prezto:module:prompt' theme 'steeef'

# Other plugins
zplug "k4rthik/git-cal", as:command # display a github like contribution calendar wall

# Prompt theme
# POWERLEVEL9K_MODE='awesome-fontconfig' # need special fonts (see powerlevel9k install doc)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=" "
# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# source ~/.zsh/zgen/zgen.zsh
# if ! zgen saved; then
#
#   # prezto options
#   zgen prezto editor key-bindings 'vi'
#   zgen prezto prompt theme 'steeef'
#
#   # specify plugins here
#   zgen prezto
#   zgen prezto environment
#   zgen prezto terminal
#   zgen prezto editor
#   zgen prezto history
#   zgen prezto directory
#   zgen prezto spectrum
#   zgen prezto utility
#   zgen prezto completion
#   zgen prezto command-not-found
#   zgen prezto node
#   zgen prezto git
#   zgen prezto prompt
#
#   # generate the init script from plugins above
#   zgen save
# fi

########################
# custom aliases
########################

alias ack=ack-grep
alias grep="nocorrect grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias gvim="UBUNTU_MENUPROXY= gvim"
alias idea=/opt/`ls /opt | grep idea`/bin/idea.sh # Intellij Idea
alias serve="python -m SimpleHTTPServer"
alias prettyjson="python -m json.tool"
alias meteo="curl -4 wttr.in/Bordeaux?lang=fr"
alias think="cd ~/think/;tree"

if [[ -a ~/.nvm/nvm.sh ]]
then
  source ~/.nvm/nvm.sh
  nvm use default
  NODE_PATH=$HOME/.nvm/`nvm ls | awk '$1 == "current:" {print $2}'`
fi

export TASKDATA=~/Dropbox/task
export TASKRC=~/Dropbox/taskrc

. /usr/share/autojump/autojump.zsh

#Desactive la completion git beaucoup trop lente
#compdef -d git

PATH=/usr/local/heroku/bin:$PATH

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$NODE_PATH/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/opt/elixir/bin # Elixir
PATH=$PATH:/opt/psysh/ # Psych : PHP REPL
PATH=$PATH:/opt/drush/ # Drupal drush
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc # phpbrew : php version manager

# PATH=$PATH:/opt/rust/bin # Rust
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rust/lib # Rust

# Include Drush bash customizations.
autoload bashcompinit
bashcompinit
if [ -f "/home/henri/.drush/drush.bashrc" ] ; then
  source /home/henri/.drush/drush.bashrc
fi
# Include Drush completion.
if [ -f "/home/henri/.drush/drush.complete.sh" ] ; then
  source /home/henri/.drush/drush.complete.sh
fi

# haskell (see https://www.reddit.com/r/haskell/comments/3bw95a/using_cabal_and_stack_together/csqdbe2)
alias cblconf='cabal configure --package-db=clear --package-db=global --package-db=$(stack path --snapshot-pkg-db) --package-db=$(stack path --local-pkg-db)'
# use stack binaries 
#PATH=/home/henri/.stack/snapshots/x86_64-linux/lts-3.4/7.10.2/bin:/home/henri/.stack/programs/x86_64-linux/ghc-7.10.2/bin:$PATH

export JAVA_HOME=/usr/lib/jvm/java-7-oracle/ # java (pour IntelliJIdea)

SCALA_HOME=/opt/scala # scalac & scala 
PATH=$PATH:$SCALA_HOME/bin:$OPENNLP_HOME/bin 
#alias sbt="java -Xmx512M -XX:MaxPermSize=256M -jar /home/henri/.IntelliJIdea14/system/sbt/sbt-launch.jar"
alias sbt="/opt/sbt"

OPENNLP_HOME=/opt/apache-opennlp-1.5.3 #openNLP 

[ -z "$TMUX" ] && export TERM=xterm-256color
#source ~/.local/bin/tmuxinator.zsh

#python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs 
export PROJECT_HOME=$HOME/travaux
source /usr/local/bin/virtualenvwrapper.sh

#NIX
if [ -d "/home/henri/.nix-profile/" ];
then
  . /home/henri/.nix-profile/etc/profile.d/nix.sh
fi

# @description Open given file with adequate rights (sudo/user)
# @param    $@|$f  file(s) name
# @return    void
function e() {
  f="$1"

  if [[ -w "$f" ]]; then
    "$EDITOR" -- "$f"
  else
    sudo -e -- "$f"
  fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
