#!/bin/bash

show_cal=true
selection='<'

if [ "$1" == "<" ]; then
	if [ -z "$ROFI_INFO" ]; then
		export ROFI_INFO=0
	fi
	export ROFI_INFO=$(expr $ROFI_INFO - 1)
elif [ "$1" == ">" ]; then
	if [ -z "$ROFI_INFO" ]; then
		export ROFI_INFO=0
	fi
	selection='>'
	export ROFI_INFO=$(expr $ROFI_INFO + 1)
elif [ "$1" == "0" ]; then
	export ROFI_INFO=0
else
	export ROFI_INFO=0
	show_cal=false
fi

if [ "$show_cal" = true ]; then
	string=$(python3 ~/.config/rofi/calendar_print.py $ROFI_INFO)
	lines=7
	if [[ $(echo "$string" | wc -l) > 49 ]]; then
		lines=8
	fi
	echo -en "$string" | rofi -dmenu -hover-select -me-select-entry '' -me-accept-entry MousePrimary -select $selection -l $lines -theme ~/.config/rofi/calendar-uncreative.rasi | xargs sh ~/.config/rofi/calendar.sh
fi

