#!/bin/bash

LAYOUT=$(setxkbmap -query | awk '/layout/ {print $2}')

if [[ "$LAYOUT" == "lt" ]]; then
   setxkbmap us
   pkill -RTMIN+30 dwmblocks
else
   setxkbmap lt
   pkill -RTMIN+30 dwmblocks
fi
