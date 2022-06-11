#!/bin/bash

# Start pulseaudio
pulseaudio -D
pulseaudio --start

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
if [[ -z "$1" ]]; then
	polybar -c $HOME/.config/polybar/config example
elif [[ "$1" == "-s" ]]; then
	polybar -c $HOME/.config/polybar/s-config example
elif [[ "$1" == "-w" ]]; then
	polybar -c $HOME/.config/polybar/workspace-display main
fi

echo "Polybar launched..."
