#!/bin/bash

# terminate any running waybar instances
killall -q waybar

# launch waybar
if [[ -z "$1" ]]; then
	waybar & disown
fi

echo "waybar successfully launched"
