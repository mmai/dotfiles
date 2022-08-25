# XXX : don't forget to make a `zinit update` from time to time to update plugins

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
#  * nnn, lf, vifm, ranger, mc : file managers
#  * taskwarrior
#  * ncdu : ncurses disk usage
#  * htop
#  * iotop
#  * lnav : log files navigator
#  * xsv : query and manipulate csv files (very good complement to awk, allow to make joins and select by field name)
#  * asciinema, ttystudio: terminal recorders (web, gif)
#  * tldr : Simplified and community-driven man pages  
#  * howdoi : Google for tech question from the command line
#  * neofetch : system config infos 
#  * cal : calendrier
#  * meteo
#  * git cal : show github like commits wall
#  * lg (lazygit), tig : handy interfaces to git
#  * xdotool : X11 automation (click on key, on mouse buttons, manipulate windows, ...)

if [[ -d /nix/store ]]; then # on NixOS
  HAS_NIXOS=1
fi

########################
# Zinit zsh plugins manager 
########################
if [[ $HAS_NIXOS == 1 ]]; then
  source "/run/current-system/sw/share/zinit/zinit.zsh"
else

  ### Added by Zinit's installer
  if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
      print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-         continuum/zinit%F{220})…%f"
      command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
      command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
          print -P "%F{33} %F{34}Installation successful.%f%b" || \
          print -P "%F{160} The clone has failed.%f%b"
  fi

  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  # Load a few important annexes, without Turbo
  # (this is currently required for annexes)
  zinit light-mode for \
      zdharma-continuum/zinit-annex-as-monitor \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl \
      zdharma-continuum/zinit-annex-rust

  ### End of Zinit's installer chunk

fi

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

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
zinit light Aloxaf/fzf-tab # replace zsh completion by fzf interface
#   list of completions
zinit ice blockf
zinit light zsh-users/zsh-completions
# zinit light mmai/guix-zsh-completions # fork of zinit light Emiller88/guix-zsh-completions with `guix shell` completion
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

zinit load zsh-users/zsh-syntax-highlighting

if [[ $HAS_NIXOS == 1 ]]; then
  zinit load spwhitt/nix-zsh-completions
fi
# ---------- end zinit specific code

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
. $HOME/.zsh/nnn.zsh # nnn file explorer config

if [[ -a ~/.nvm/nvm.sh ]]
then
  source ~/.nvm/nvm.sh
  nvm use default
  NODE_PATH=$HOME/.nvm/`nvm ls | awk '$1 == "current:" {print $2}'`
fi

export EDITOR=nvim
# export EDITOR=ewrap.sh # (in .local/bin/ewrap.sh) open in split tmux window
export PAGER="less -Ri"

export LEDGER_FILE=~/think/finance/$(date +%Y).journal

# export JAVA_HOME=$HOME/softs_/jdk 
# export JRE_HOME=$JAVA_HOME/jre
# export ANDROID_HOME=$HOME/softs_/android-studio-sdk

#Desactive la completion git beaucoup trop lente
#compdef -d git

# add Cabal's bin directory to the executable search PATH if it exists
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$HOME/.cabal/bin:$PATH"
fi

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$NODE_PATH/bin
PATH=$PATH:$HOME/.npm-global/bin # set global npm directory with `npm set prefix ~/.npm-global` (needed on nixos system because node install path is not writable)
PATH=$PATH:$HOME/.yarn/bin
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

# Guix asked to put this after `guix update` :
# GUIX_PROFILE="/home/henri/.config/guix/current"
# source "$GUIX_PROFILE/etc/profile"
# ... and then to put this after `guix install emacs` :
# GUIX_PROFILE="/home/henri/.guix-profile"
# source "$GUIX_PROFILE/etc/profile"

# SCALA_HOME=/opt/scala # scalac & scala 
# PATH=$PATH:$SCALA_HOME/bin:$OPENNLP_HOME/bin 
#alias sbt="java -Xmx512M -XX:MaxPermSize=256M -jar /home/henri/.IntelliJIdea14/system/sbt/sbt-launch.jar"
# alias sbt="/opt/sbt"

OPENNLP_HOME=/opt/apache-opennlp-1.5.3 #openNLP 

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
# Ctrl-R : historique (copié de key-bindings.zsh, non dispo sous guix)
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^\s*[0-9]+\**\s+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

if [[ $HAS_NIXOS == 1 ]]; then
  if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.zsh"
    source "$(fzf-share)/completion.zsh"
  fi
else
  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget
fi

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

# Direnv (enable overrides of env variables in directories with a .envrc file)
eval "$(direnv hook zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# any-nix-shell zsh --info-right | source /dev/stdin
enable-fzf-tab

# Automatically launch tmux with a new session attached to default windows group
# if command -v tmux &> /dev/null && [ -n "$ps1" ] && [[ ! "$term" =~ screen ]] && [[ ! "$term" =~ tmux ]] && [ -z "$tmux" ]; then
#   # export term=screen-256color # 'screen' instead of 'xterm' for ratpdev compatibility 
#   exec "tmux new-session -t main"
# fi

