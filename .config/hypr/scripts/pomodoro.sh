#!/bin/bash

while true; do
    for i in {1..4}; do
        notify-send "work!"
#        export POMODORO='on work'
        sleep 1500

        notify-send "short break!"
#        export POMODORO='on short break'
        sleep 300
    done

    notify-send "long break!"
#    export POMODORO='on long break'
    sleep 1200
done

