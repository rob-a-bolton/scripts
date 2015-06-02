#!/bin/bash
workspaceline=$( wmctrl -d | sed 's/ \+/ /g' | cut -d' ' -f 1,10- | dmenu $DMENU_ARGS -i -l 8 -p "Workspace:")
if [[ -n "$workspaceline" ]]; then
    wmctrl -s $(echo "$workspaceline" | cut -d' ' -f 1)
fi
