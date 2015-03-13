#!/bin/sh

if [[ ! -e ~/.ratpoison/sblank ]]; then
    echo "No blank state stored, cannot restore"
    exit
fi

if [[ -e ~/.ratpoison/hide-dump ]]; then
    blankFrames=$(cat ~/.ratpoison/sblank | sed 's/last-access [0-9]*/last-access 0/g')
    currentFrames=$(ratpoison -c sfdump | sed 's/last-access [0-9]*/last-access 0/g')
    if [[ "$blankFrames" == "$currentFrames" ]]; then
        ratpoison -c "sfrestore $(cat ~/.ratpoison/hide-dump)"
    else
        exit 1
    fi
fi
