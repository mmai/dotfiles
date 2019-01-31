alias journal='~/travaux/ecrits/journal.sh'
alias scaffold='~/Travaux/programmes/scaffold/scaffold'

alias gll="git log --graph --oneline --abbrev-commit --decorate --all"

# Tools
#    Copy screenshot to file
#       Take screenshot whith <ctrl><shift><printScreen>, then  `pngpaste > screenshot.png`
alias pngpaste="xclip -sel clipboard -t image/png -o" 
alias pasteocr="pngpaste | convert -resize 400% /dev/stdin /dev/stdout | tesseract stdin stdout"
alias pasteshow="pngpaste > screenshot.png && eog screenshot.png" 

# better alternatives
alias cat="bat"
alias ping="prettyping --nolegend"
alias vim="nvim"

# Dev tools
alias serve="python -m SimpleHTTPServer"
alias prettyjson="python -m json.tool"
alias ip="curl curlmyip.com" # print my IP

# Fun scripts
alias meteo="curl -4 http://wttr.in/Bordeaux?lang=fr"
alias coin="coinmon -c eur -f btc,miota,eth,ltc,xrp,xtz,nlg,plbt"
alias think="cd ~/think/;tree"
alias mthink="cd ~/mthink/;tree"
alias dlmusic="~/softs_/dlmusic.sh"

# haskell (see https://www.reddit.com/r/haskell/comments/3bw95a/using_cabal_and_stack_together/csqdbe2)
alias cblconf='cabal configure --package-db=clear --package-db=global --package-db=$(stack path --snapshot-pkg-db) --package-db=$(stack path --local-pkg-db)'

# Atixnet
alias tax="task +Atixnet"
alias vpn="~/softs_/vpn.sh"

###############
# Git
###############
# resuable format strings
GIT_PRETTY_FORMAT="--pretty=\"%C(bold green)%h%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_AUTHOR="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s\""

# pretty Git log
alias gl="git log --graph $GIT_PRETTY_FORMAT"
# pretty Git log, all references
alias gll='gl --all'
# pretty Git log, show authors
alias gla="git log --graph $GIT_PRETTY_FORMAT_AUTHOR"
# pretty Git log, all references, show authors
alias glla='gla --all'

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
# projects=$(~/softs_/projects_without_next_action.sh)
# if [ "$projects" != "" ]
# then
#   echo $fg[red] "Attention: The following projects don't currently have a next action:\n"
#   echo $projects
#   echo
# fi
#    Show waiting-for items
# waiting=$(task +waiting +PENDING count)
# if [ "$waiting" != "0" ]
# then
#   echo "Any progress on these waiting-fors?"
#   task +waiting +PENDING ls
# fi

