#!/bin/bash

pid=$(ps -ef | grep 'sh.*\.config/hypr/scripts/posture_check.sh' | grep -v 'grep' | awk '{print $2}')

if [[ -n $pid ]]; then
    kill $pid
    notify-send "posture check ended"
else
    sh ~/.config/hypr/scripts/posture_check.sh & disown
fi

