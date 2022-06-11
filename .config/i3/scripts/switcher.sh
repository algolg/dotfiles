#!/bin/bash

if [[ -z "$1" ]]; then
	win_class=$(xdotool getwindowfocus getwindowclassname)
else
	win_class=$1
fi

# get list of all windows matching with the class above
win_list=$(wmctrl -x -l | grep ".$win_class " | awk '{print $1}' )

# get id of the focused window
active_win_id=$(xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}')
while [ ${#active_win_id} -lt 8 ]; do
	active_win_id="0$active_win_id"
done

if [ "$active_win_id" == "00000000" ]; then
	    active_win_id=""
fi

# get next window to focus on, removing id active
switch_to=$(echo $win_list | sed s/.*$active_win_id// | awk '{print $1}')

# if the current window is the last in the list ... take the first one
if [ "$switch_to" == '' ];then
	   switch_to=$(echo $win_list | awk '{print $1}')
fi

# switch to window
wmctrl -i -a $switch_to
