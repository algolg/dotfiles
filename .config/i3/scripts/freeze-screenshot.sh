# take screenshot without cursor and pipe to feh, get its pid
maim -u | feh - &
feh_pid=$!

# wait for feh to start
while [ -z "$(xdotool search --pid "$feh_pid")" ]; do
	    sleep 0.1
    done

    # get window ID of feh
    wid="$(xdotool search --pid "$feh_pid")"

    # fullscreen feh and move top-left (works with multi-monitor)
    xdotool windowsize "$wid" 100% 100%
    xdotool windowmove "$wid" 0 0

    # take the new screenshot by selection, pipe to clipboard
    maim -s | xclip -selection clipboard -t image/png

    # kill feh
    kill "$feh_pid"

    # send notification
    notify-send --icon /usr/share/icons/Fancy-Dark-Icons/apps/48/spectacle.
        svg "Rectangular Region Captured"
