#!/bin/bash

if [[ -z "$1" ]]; then
	win_class=$(xdotool getwindowfocus getwindowclassname)
else
	win_class=$1
fi

# get list of all windows matching with the class above
win_list=$(wmctrl -x -l | grep ".$win_class " | awk '{print $1}' )

# if the current window is the last in the list ... take the first one
if [ "$switch_to" == '' ];then
	   switch_to=$(echo $win_list | awk '{print $1}')
fi

# switch to window
wmctrl -i -a $switch_to
