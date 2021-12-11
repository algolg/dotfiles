#!/bin/bash

# Terminate already running picom instances
pkill picom

sleep 1
# Launch Picom, using default config location ~/.config/picom
picom -b

echo "Picom launched..."
