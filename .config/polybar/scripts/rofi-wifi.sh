#!/bin/bash


if [[ -z "$1" ]]; then
	nmcli -t -f active,ssid,bars dev wifi | sed 's/no/ */' | sed 's/yes/CON/' > temp && column -s ":" -t temp | awk '!($2 ~ /▂/)' | rofi -i -dmenu -theme ~/.config/rofi/wifi-menu-uncreative.rasi -font "Consolas 14" | awk '{print $2}' | xargs nmcli dev wifi connect
	rm temp
elif [[ "$1" == "--toggle" ]]; then
	if nmcli radio wifi | grep -q "enabled"; then
		nmcli radio wifi off
		notify-send --icon /usr/share/icons/Fancy-Dark-Icons/actions/24/network-disconnect.svg "Wi-Fi Disabled" "nmcli radio wifi off"
	else
		nmcli radio wifi on		
		notify-send --icon /usr/share/icons/Fancy-Dark-Icons/actions/24/network-connect.svg "Wi-Fi Enabling" "nmcli radio wifi on"
	fi
fi
