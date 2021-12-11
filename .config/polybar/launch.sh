#!/bin/bash

# Start pulseaudio
pulseaudio -D
pulseaudio --start

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config
polybar -c $HOME/.config/polybar/config example

echo "Polybar launched..."
