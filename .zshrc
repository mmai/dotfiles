# terminal utilities
#  * z : go to recent /frequent directories
# some terminal programs : 
#  * vifm, ranger, mc : file managers
#  * taskwarrior
#  * ncdu : ncurses disk usage
#  * htop
#  * tldr : Simplified and community-driven man pages  
#  * neofetch : system config infos 
#  * cal : calendrier
#  * meteo
#  * git cal : show github like commits wall

# enable the ctrl-shift-t command in termite to open a new terminal window in the current directory (cf. https://github.com/thestinger/termite)
if [[ $TERM == xterm-termite ]]; then
  source /usr/local/etc/profile.d/vte.sh
  __vte_osc7
fi

# export TERM="xterm-256color"
# themes couleurs 'base16' pour xfce4-terminal : https://github.com/afg984/base16-xfce4-terminal (config depuis Edit > Preferences > Colors > Presets)
# summerfruit dark est pas mal


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
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' keymap 'vi'

# nix-shell compatibility 
zplug "chisui/zsh-nix-shell"

# pure prompt
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# Other plugins
zplug "rupa/z", use:z.sh # z www myweb => go to the most frequent/recent dir matching 'www' then 'myweb' (ex :/var/www/myweb/)
zplug "k4rthik/git-cal", as:command # display a github like contribution calendar wall
zplug "zsh-users/zsh-syntax-highlighting"
zplug "spwhitt/nix-zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# use vim keys to edit command line
  # must be after 'zplug load'
bindkey -v

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
alias coin="coinmon -c eur -f btc,miota,eth,ltc,xrp,xtz,nlg,plbt"
alias think="cd ~/think/;tree"
alias tax="task +Atixnet"
alias vpn="~/softs_/vpn.sh"

if [[ -a ~/.nvm/nvm.sh ]]
then
  source ~/.nvm/nvm.sh
  nvm use default
  NODE_PATH=$HOME/.nvm/`nvm ls | awk '$1 == "current:" {print $2}'`
fi

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/ # java (pour IntelliJIdea)
export JRE_HOME=/usr/lib/jvm/java-8-oracle/jre 
export ANDROID_HOME=/opt/android-sdk-linux/

#Desactive la completion git beaucoup trop lente
#compdef -d git

PATH=/usr/local/heroku/bin:$PATH

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$NODE_PATH/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/opt/elixir/bin # Elixir
PATH=$PATH:/opt/psysh/ # Psych : PHP REPL
PATH=$PATH:/opt/drush/ # Drupal drush
PATH=$PATH:$ANDROID_HOME/tools/
PATH=$PATH:$ANDROID_HOME/platform-tools/
PATH=$PATH:/opt/android-studio/bin/ # Android STudio

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

##################
# FZF fuzzy finder
##################
# Ctrl-R : historique
# vim ./src/**<TAB>  completion sur le répertoire...
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use ag instead of the default find command for listing candidates.
_fzf_compgen_path() {
  ag -g "" "$1"
}

##
# tiny care terminal
#
export TTC_APIKEYS=false
export TTC_WEATHER='Bordeaux'
export TTC_REPOS='/var/www,/home/henri/travaux'

#################
# Notes
#################
# Préparation : cd ~ ; git clone rhumbs.fr:~henri/repositories/notes.git notes
source ~/notes/notes.sh

##################
# Taskwarrior utils
##################
# inbox
alias in='task add +in'
tp () {
  task project:$1
}

# tickle 
tickle () {
    deadline=$1
    shift
    in +tickle wait:$deadline $@
}
alias tick=tickle
#alias think='tickle +1d'
#    Show projects without next actions
projects=$(~/softs_/projects_without_next_action.sh)
if [ "$projects" != "" ]
then
  echo $fg[red] "Attention: The following projects don't currently have a next action:\n"
  echo $projects
  echo
fi
#    Show waiting-for items
waiting=$(task +waiting +PENDING count)
if [ "$waiting" != "0" ]
then
  echo "Any progress on these waiting-fors?"
  task +waiting +PENDING ls
fi
source /opt/git-subrepo/.rc
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=/home/henri/.local/bin/luna-studio:$PATH
