#!/bin/sh

if [[ ! -e ~/.ratpoison/sblank ]]; then
    echo "Blank frames not set up, exiting..."
    exit
fi

blankFrames=$(cat ~/.ratpoison/sblank | sed 's/last-access [0-9]*/last-access 0/g')
currentFrames=$(ratpoison -c sfdump | sed 's/last-access [0-9]*/last-access 0/g')

if [[ "$blankFrames" != "$currentFrames" ]]; then
    ratpoison -c sfdump > ~/.ratpoison/hide-dump
    ratpoison -c "sfrestore $(cat ~/.ratpoison/sblank)"
else
    exit 1
fi
