#!/bin/bash
function keyboard {
	options="gb\nus\nlt"
	selected=$(echo -e $options | dmenu "$@" )
	if [[ $selected = "gb" ]]; then 
   		setxkbmap gb  
  		pkill -RTMIN+30 dwmblocks
	elif [[ $selected = "us" ]]; then
   		setxkbmap us
  		pkill -RTMIN+30 dwmblocks
	elif [[ $selected = "lt" ]]; then
   		setxkbmap lt
  		pkill -RTMIN+30 dwmblocks
	fi
}
keyboard "$@"
