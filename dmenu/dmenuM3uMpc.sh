#!/bin/sh

[ -z $1 ] && exit 1

stream=$(dmenu -p "Stream: " -l `wc -l "$1" | cut -d" " -f 1` $DMENU_ARGS < $1)

[ -z $stream ] && exit 2

mpc clear
mpc add "$stream"
mpc play
