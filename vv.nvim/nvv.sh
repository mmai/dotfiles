#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
XDG_CONFIG_HOME=$DIR
XDG_DATA_HOME=$DIR/data
XDG_CACHE_HOME=$DIR/cache

VIMCONF=$VIMCONF XDG_CONFIG_HOME=$XDG_CONFIG_HOME XDG_CACHE_HOME=$XDG_CACHE_HOME XDG_DATA_HOME=$XDG_DATA_HOME nvim -u ./init.lua --cmd "set rtp+=." "$@"
