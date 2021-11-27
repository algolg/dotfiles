#!/bin/bash

# Terminate already running picom instances
killall -q picom

# Launch Picom, using default config location ~/.config/picom
picom

echo "Picom launched..."
