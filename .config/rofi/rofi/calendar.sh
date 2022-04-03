#!/bin/bash

{ ncal -bh; echo -en "\x0f"; ncal -b 2 2022;} | rofi -dmenu -sep '\x0f' -eh 9 -theme ~/.config/rofi/calendar-uncreative.rasi
