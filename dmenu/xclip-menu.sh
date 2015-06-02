#!/bin/bash
export DMENU_optionscript=$( ls ~/Scripts/dmenu/clipboardscripts/ | dmenu $DMENU_ARGS -i -l 8)
[ -z $DMENU_optionscript ] && exit
xclip -out -sel clipboard | ~/Scripts/dmenu/clipboardscripts/$DMENU_optionscript | xclip -in -sel clipboard
xclip -out -sel clipboard | xclip -in -sel primary
