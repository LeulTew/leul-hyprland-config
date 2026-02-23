#!/usr/bin/env bash
# /* ---- 💫 WallpaperDellRandom.sh 💫 ---- */
# Sets a random wallpaper on HDMI-A-1 (external Dell monitor) only.
# eDP-1 (laptop) keeps its current wallpaper unchanged.

PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
wallDIR="$PICTURES_DIR/wallpapers/Dynamic-Wallpapers/Dark"


# Get all connected monitors
mapfile -t MONITORS < <(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Pick a random wallpaper
mapfile -t PICS < <(find "$wallDIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.bmp" \))
RANDOMPIC="${PICS[$RANDOM % ${#PICS[@]}]}"

# Transition config
FPS=60
TYPE="random"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

swww query || swww-daemon --format xrgb &
sleep 0.5

# Apply to all monitors
for MONITOR in "${MONITORS[@]}"; do
    swww img -o "$MONITOR" "${RANDOMPIC}" $SWWW_PARAMS
done

