#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
[ -f /tmp/polybar_top.log ] && rm -f /tmp/polybar_top.log
[ -f /tmp/polybar_bottom.log ] && rm -f /tmp/polybar_bottom.log
polybar top -c "$DIR"/config.ini | tee -a /tmp/polybar_top.log & disown
polybar bottom -c "$DIR"/config.ini | tee -a /tmp/polybar_bottom.log & disown
