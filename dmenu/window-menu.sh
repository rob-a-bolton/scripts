#!/bin/bash
export DMENU_windowline=$( wmctrl -x -l | sed "s/$HOSTNAME //" | dmenu $DMENU_ARGS -i -l 8 -p "Window menu:")
[[ -z "$DMENU_windowline" ]] && exit
#window=$(echo "$workspaceline" | cut -d' ' -f 1)
#optionscript=$( ls -l ~/Scripts/dmenu/windowscripts/ | tail -n +2 | cut -d' ' -f 10- | dmenu $DMENU_ARGS -i -l 8)
export DMENU_optionscript=$( ls ~/Scripts/dmenu/windowscripts/ | dmenu $DMENU_ARGS -i -l 8)
export DMENU_windownumber=$(echo $DMENU_windowline | cut -d' ' -f 1)
export DMENU_windowname="$(wmctrl -l | grep "$DMENU_windownumber" | cut -d' ' -f 5-)"
~/Scripts/dmenu/windowscripts/$DMENU_optionscript "$DMENU_windownumber" "$DMENU_windowname" "$DMENU_windowline"
