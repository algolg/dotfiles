#!/bin/bash

print=""

for i in {1..31}
do
	print="${print}${i}\n"
done

echo -e "$print" | rofi -dmenu -theme ~/.config/rofi/calendar-uncreative.rasi
