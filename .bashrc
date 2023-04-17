# Check for an interactive session
[ -z "$PS1" ] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Aliases (shared with zsh)
.  $HOME/.zsh/aliases.sh

# specific bash aliases
alias ls='ls --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
export PYTHONSTARTUP=${HOME}/.pythonrc
if [[ -a ~/.nvm/nvm.sh ]];then source ~/.nvm/nvm.sh;fi

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:$HOME/.config/composer/vendor/bin/ # Binaries installed from (ie Psych : PHP REPL)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
