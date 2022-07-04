# XXX dont forget to make a `zinit update` from time to time to update plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# terminal utilities
#  * z : go to recent /frequent directories
#  * fzf : fuzzy finder / navigator `fd --extension md | fzf | xargs bat`
#  * entr : run arbitrary commands when files change (example: ls *.hs | entr make build)
# some terminal programs : 
#  * lf, vifm, ranger, mc : file managers
#  * taskwarrior
#  * ncdu : ncurses disk usage
#  * htop
#  * iotop
#  * lnav : log files navigator
#  * asciinema, ttystudio: terminal recorders (web, gif)
#  * tldr : Simplified and community-driven man pages  
#  * howdoi : Google for tech question from the command line
#  * neofetch : system config infos 
#  * cal : calendrier
#  * meteo
#  * git cal : show github like commits wall
#  * xdotool : X11 automation (click on key, on mouse buttons, manipulate windows, ...)

# enable the ctrl-shift-t command in termite to open a new terminal window in the current directory (cf. https://github.com/thestinger/termite)
if [[ $TERM == xterm-termite ]]; then
  source /usr/local/etc/profile.d/vte.sh
  __vte_osc7
fi

# export TERM="xterm-256color"
# themes couleurs 'base16' pour xfce4-terminal : https://github.com/afg984/base16-xfce4-terminal (config depuis Edit > Preferences > Colors > Presets)
# summerfruit dark est pas mal

WITH_ZINIT=1

if [[ $WITH_ZINIT == 1 ]]; then
########################
# Zinit zsh plugins manager 
########################
ZINIT_HOME=/run/current-system/sw/share/zinit
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Prezto plugins
zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/terminal/init.zsh
zinit snippet PZT::modules/editor/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/spectrum/init.zsh

#Defines general aliases and functions ; used by modules/completion
# zinit ice svn pick "init.zsh"
# zinit snippet PZT::modules/utility
# zinit ice svn pick "init.zsh"
# zinit snippet PZT::modules/completion

zinit ice svn pick "init.zsh"
zinit snippet PZT::modules/node
zinit ice svn pick "init.zsh"
zinit snippet PZT::modules/git
# zstyle ':prezto:*:*' color 'yes'
# zstyle ':prezto:module:editor' keymap 'vi'
#
# autocompletion
#   fzf-tab : enable with `enable-fzf-tab`
zinit light Aloxaf/fzf-tab
#   list of completions
zinit ice blockf
zinit light zsh-users/zsh-completions
# don't systematicly show users directory in cd completions
unsetopt cdablevars

# autosuggestion (fish like command preview)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# pure prompt
# forked from sindresorhus/pure (added nix-shell info)
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light mmai/pure

# z www myweb => go to the most frequent/recent dir matching 'www' then 'myweb' (ex :/var/www/myweb/)
zinit load agkozak/zsh-z

 # zsh as default nix shell
zinit load chisui/zsh-nix-shell
zinit load zsh-users/zsh-syntax-highlighting
zinit load spwhitt/nix-zsh-completions
else

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
# zplug "modules/command-not-found", from:prezto # already active on NixOS
zplug "modules/node", from:prezto
zplug "modules/git", from:prezto
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' keymap 'vi'

# pure prompt
zplug "mafredri/zsh-async"
zplug "mmai/pure" # forked from sindresorhus/pure (added nix-shell info)

# nix-shell compatibility 
zplug "chisui/zsh-nix-shell" #Pb : alias defined in the default.nix shellHook are not recognized anymore 
# Other plugins
zplug "rupa/z", use:z.sh # z www myweb => go to the most frequent/recent dir matching 'www' then 'myweb' (ex :/var/www/myweb/)
zplug "k4rthik/git-cal", as:command # display a github like contribution calendar wall
zplug "zsh-users/zsh-syntax-highlighting"
zplug "spwhitt/nix-zsh-completions"

zplug "Aloxaf/fzf-tab"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
fi

# ------ fzf-tab configuration
enable-fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


# use vim keys to edit command line
  # must be after 'zplug load'
bindkey -v

# fix "no matches found" when referencing HEAD^
unsetopt nomatch

# Aliases (shared with bash)
. $HOME/.zsh/aliases.sh

if [[ -a ~/.nvm/nvm.sh ]]
then
  source ~/.nvm/nvm.sh
  nvm use default
  NODE_PATH=$HOME/.nvm/`nvm ls | awk '$1 == "current:" {print $2}'`
fi

export EDITOR=nvim

export LEDGER_FILE=~/think/finance/$(date +%Y).journal

# export JAVA_HOME=$HOME/softs_/jdk 
# export JRE_HOME=$JAVA_HOME/jre
# export ANDROID_HOME=$HOME/softs_/android-studio-sdk

#Desactive la completion git beaucoup trop lente
#compdef -d git

PATH=/usr/local/heroku/bin:$PATH

# add Cabal's bin directory to the executable search PATH if it exists
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$NODE_PATH/bin
PATH=$PATH:$HOME/.npm-global/bin # set global npm directory with `npm set prefix ~/.npm-global` (needed on nixos system because node install path is not writable)
PATH=$PATH:$HOME/.yarn/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/opt/elixir/bin # Elixir
PATH=$PATH:$HOME/.config/composer/vendor/bin/ # Binaries installed from composer (ie Psych : PHP REPL, phpcs...)
PATH=$PATH:$HOME/.cargo/bin # Rust
PATH=$PATH:/opt/drush/ # Drupal drush
PATH=$HOME/.symfony/bin:$PATH # Symfony
# PATH=$PATH:$JAVA_HOME/bin
# PATH=$PATH:$ANDROID_HOME/tools/
# PATH=$PATH:$ANDROID_HOME/platform-tools/
# PATH=$PATH:/softs_/android-studio/bin
# PATH=$PATH:$HOME/softs_/android-studio/gradle/gradle-5.1.1/bin

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

# SCALA_HOME=/opt/scala # scalac & scala 
# PATH=$PATH:$SCALA_HOME/bin:$OPENNLP_HOME/bin 
#alias sbt="java -Xmx512M -XX:MaxPermSize=256M -jar /home/henri/.IntelliJIdea14/system/sbt/sbt-launch.jar"
# alias sbt="/opt/sbt"

OPENNLP_HOME=/opt/apache-opennlp-1.5.3 #openNLP 

[ -z "$TMUX" ] && export TERM=xterm-256color

#NIX : uncomment on non NixOS systems
# if [ -d "/home/henri/.nix-profile/" ];
# then
#   . /home/henri/.nix-profile/etc/profile.d/nix.sh
# # executer: nix-env -iA nixpkgs.glibcLocales
#   export LOCALE_ARCHIVE="$(readlink ~/.nix-profile/lib/locale)/locale-archive"
# fi

# needed for nix-shell ?? (sinon erreur "perl: warning: Setting locale failed.")
export LANGUAGE=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8

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
FZFPATH=$(nix-store -r $(which fzf) 2> /dev/null)
# FZFPATH=$(nix eval nixpkgs#fzf.outPath | sed -e 's/"//g') # makes a remote connection
[[ $- == *i* ]] && source $FZFPATH"/share/fzf/completion.zsh" 2> /dev/null
source $FZFPATH"/share/fzf/key-bindings.zsh"
# Use rg instead of the default find command for listing candidates.
_fzf_compgen_path() {
  rg -g "" "$1"
}

# Tmuxp
eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"

fzf-tmuxp-sessions() {
  CMD=$(find ~/.tmuxp/ -type f | fzf)
  # tmuxp load -y $CMD # XXX strange behavior : start session but not on current terminal
  zle -U "tmuxp load -y $CMD"
  zle accept-line
}
zle -N fzf-tmuxp-sessions
bindkey '^S' fzf-tmuxp-sessions

# pass
fzf-pass() {
    CMD=$(find ~/.password-store/ -name "*.gpg"        | \
        sed -r 's,(.*)\.password-store/(.*)\.gpg,\2,' | fzf)

    pass -c $CMD
  # zle -U "pass -c $CMD"
  # zle accept-line
}
zle -N fzf-pass
bindkey '^P' fzf-pass

# templates
TPL_DIR=$HOME/dotfiles/templates
fzf-templates() {
    TPL=$(ls $TPL_DIR | fzf)
    zle -U "zsh $TPL_DIR/$TPL/install.sh"
}
zle -N fzf-templates
bindkey '^T' fzf-templates

# Hide the gnome-terminal header bar
# if [ "$TERM" = "xterm-256color" ]; then
#   xprop \
#     -id $(xdotool getactivewindow) \
#     -f _MOTIF_WM_HINTS 32c \
#     -set _MOTIF_WM_HINTS "0x2, 0x0, 0x0, 0x0, 0x0"
# fi

export PATH=/home/henri/.local/bin/luna-studio:$PATH

source /home/henri/.config/broot/launcher/bash/br

# Direnv (enable overrides of env variables in directories with a .envrc file)
eval "$(direnv hook zsh)"

#########################
#  lf file browser
#########################
# wrapper to cd on the last directory opened on lf
lf () {
    tmp="$(mktemp)"
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# This snippet adds a a zsh key binding Alt-k that opens lf in a tmux split.
# Pressing a in lf adds the selected file(s) to the zsh command line as relative paths,
# A adds absolute paths. . changes the zsh directory.
_zlf() {
    emulate -L zsh
    local d=$(mktemp -d) || return 1
    {
        mkfifo -m 600 $d/fifo || return 1
        tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
        local fd
        exec {fd}<$d/fifo
        zle -Fw $fd _zlf_handler
    } always {
        rm -rf $d
    }
}
zle -N _zlf
bindkey '\ek' _zlf

_zlf_handler() {
    emulate -L zsh
    local line
    if ! read -r line <&$1; then
        zle -F $1
        exec {1}<&-
        return 1
    fi
    eval $line
    zle -R
}
zle -N _zlf_handler

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

enable-fzf-tab

# Automatically launch tmux with a new session attached to default windows group
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -t main 
fi
