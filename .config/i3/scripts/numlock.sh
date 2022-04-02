#!/bin/bash

if xset q | grep Num | awk '{print $8}' | grep -q "off"; then
	notify-send "off"
	xmodmap -e "keycode 84 = KP_Down"
else
	notify-send "on"
	setxkbmap -layout us
fi
