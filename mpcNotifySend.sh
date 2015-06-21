#!/bin/sh
song=$(mpc status -f "%title%" | head -n 1)
[ -z $song ] && song="Not currently playing."
notify-send -u normal "$song"
