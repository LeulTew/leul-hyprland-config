#!/usr/bin/env bash

# Kill all existing waybar instances
killall -q waybar
pkill -x waybar

# Wait for them to actually terminate to avoid race conditions
while pidof waybar >/dev/null; do
    sleep 0.1
done

# Launch a single new waybar instance
waybar > /dev/null 2>&1 &
