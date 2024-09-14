#!/bin/bash

first_char=$(sed '33q;d' ~/.config/hypr/hypridle.conf | cut -c 1)

if [[ "$first_char" = "#" ]]; then
    sed -i '33 s/#//' ~/.config/hypr/hypridle.conf
fi

hyprctl dispatch exec hypridle
    
