#!/bin/bash

pid=$(ps -ef | grep 'sh.*\.config/hypr/scripts/pomodoro.sh' | grep -v 'grep' | awk '{print $2}')

if [[ -n $pid ]]; then
    kill $pid
    notify-send "pomodoro ended"
else
    sh ~/.config/hypr/scripts/pomodoro.sh & disown
fi

