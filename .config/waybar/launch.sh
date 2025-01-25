#!/bin/bash

# terminate any running waybar instances
killall -q waybar

# launch waybar
if [[ "$1" == "small" ]] || hyprctl getoption general:gaps_in | grep -q "0 0 0 0"; then
        waybar -c ~/.config/waybar/config-small -s ~/.config/waybar/style-small.css & disown
elif [[ -z "$1" ]]; then
	waybar & disown
fi

echo "waybar successfully launched"
