#!/bin/bash


if [[ -z "$1" ]]; then
	SSID=$(nmcli -t -f active,ssid,bars dev wifi | sed 's/no/ */' | sed 's/yes/CON/' > temp && column -s ":" -t temp | awk '!($2 ~ /▂/)' | rofi -i -dmenu -theme wifi-menu-uncreative -font "Consolas 14" | awk '{print $2}')
	rm temp
	RESPONSE=$(nmcli dev wifi connect $SSID)
	if [[ "$RESPONSE" =~ "Secrets were required" ]]; then
		PASS=$(echo "Password Needed" | rofi -dmenu -password -theme wifi-menu-uncreative -font "Consolas 14")
		nmcli dev wifi connect $SSID password $PASS
	fi
elif [[ "$1" == "--toggle" ]]; then
	if nmcli radio wifi | grep -q "enabled"; then
		nmcli radio wifi off
		notify-send --icon /usr/share/icons/Fancy-Dark-Icons/actions/24/network-disconnect.svg "Wi-Fi Disabled" "nmcli radio wifi off"
	else
		nmcli radio wifi on		
		notify-send --icon /usr/share/icons/Fancy-Dark-Icons/actions/24/network-connect.svg "Wi-Fi Enabling" "nmcli radio wifi on"
	fi
fi
