#!/bin/bash

first_char=$(sed '33q;d' ~/.config/hypr/hypridle.conf | cut -c 1)

killall hypridle

if [[ "$first_char" = "#" ]]; then
    sed -i '33 s/#//' ~/.config/hypr/hypridle.conf
    notify-send "Auto-suspend on"
else
    sed -i '33 s/^/#/' ~/.config/hypr/hypridle.conf
    notify-send "Auto-suspend off"
fi

hyprctl dispatch exec hypridle
    
