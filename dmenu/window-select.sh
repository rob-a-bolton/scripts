#!/bin/bash
windowline=$( wmctrl -x -l | sed "s/$HOSTNAME //" | dmenu $DMENU_ARGS -i -l 8 -p "Select window:")
if [[ -n "$windowline" ]]; then
    window=$(echo "$windowline" | cut -d' ' -f 1)
    wmctrl -i -a $window && wmctrl -b remove,shaded,hidden -i -r $window
fi
