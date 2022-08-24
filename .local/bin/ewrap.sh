#!/usr/bin/env sh

if [ -n "$TMUX" ] ; then
    # tmux session running
    tmux split-window -h "nvim \"$*\""
else
    alacritty -e "nvim \"$*\""
fi
