export PYTHONSTARTUP=${HOME}/.pythonrc

if [[ -a ~/.nvm/nvm.sh ]]
then
  source ~/.nvm/nvm.sh
  nvm use default
fi

export TASKDATA=~/Dropbox/task
export TASKRC=~/Dropbox/taskrc

#Desactive la completion git beaucoup trop lente
compdef -d git
