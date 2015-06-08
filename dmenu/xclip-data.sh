#!/bin/bash

#Find current directory, as suggested in http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
DIR=$(dirname $0)
submenus=$( ls $DIR/data-menus/ )
submenu=$( echo "$submenus" | dmenu $DMENU_ARGS -i -l 8)
[ -z $submenu ] && exit 1

choice=$( ls "$DIR/data-menus/$submenu" | dmenu $DMENU_ARGS -i -l 8)

[ -z $choice ] && exit 1

xclip -out -sel clipboard | $DIR/data-menus/$submenu/$choice | xclip -in -sel clipboard

# Synchronize clipboard & primary buffer
xclip -out -sel clipboard | xclip -in -sel primary
