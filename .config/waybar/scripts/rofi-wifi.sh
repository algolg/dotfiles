#!/bin/bash

if [[ -z "$1" ]]; then
        nmcli -t -f active,bars,ssid dev wifi > temp
        current=$(grep -v ':$' temp | grep -n -m 1 "yes:" | sed 's/:/ /g' | awk '{print $1}')
        if [[ -n $current ]]; then
            current="-a $(($current-1))"
        fi
	SSID=$(column -s ":" -t temp --table-hide 1 | awk 'NF > 1' | rofi $current -i -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -theme wifi-menu-uncreative -font "Consolas 14" | awk '{for (i=2;i<NF;i++) printf $i" "; print $NF}')
	rm temp
	response=$(nmcli dev wifi connect "$SSID" 2>&1)
	echo $response
	if [[ "$response" =~ "Secrets were required" ]]; then
		PASS=$(echo "Password Needed" | rofi -dmenu -password -theme wifi-menu-uncreative -font "Consolas 14")
		nmcli dev wifi connect "$SSID" password $PASS
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
