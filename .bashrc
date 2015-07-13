# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ack='ack-grep'

alias journal='~/travaux/ecrits/journal.sh'

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
export PYTHONSTARTUP=${HOME}/.pythonrc
if [[ -a ~/.nvm/nvm.sh ]];then source ~/.nvm/nvm.sh;fi

export TASKDATA=~/Dropbox/task
export TASKRC=~/Dropbox/taskrc

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
