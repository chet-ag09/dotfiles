#!/bin/bash

# vibe coded cuz i couldnt figure it out
WALL_DIR="$HOME/.config/hypr/wallpaper"
STATE_FILE="$HOME/.cache/wal/.current_wallpaper"

# Create state dir if missing
mkdir -p "$(dirname "$STATE_FILE")"

# Get list of images (sorted)
mapfile -t WALLS < <(find "$WALL_DIR" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \
\) | sort)

# Safety check
if [ "${#WALLS[@]}" -eq 0 ]; then
    echo "No wallpapers found in $WALL_DIR"
    exit 1
fi

# Read last wallpaper
LAST=$(cat "$STATE_FILE" 2>/dev/null)

# Find next wallpaper
NEXT=""
for i in "${!WALLS[@]}"; do
    if [ "${WALLS[$i]}" = "$LAST" ]; then
        NEXT="${WALLS[$(( (i + 1) % ${#WALLS[@]} ))]}"
        break
    fi
done

# First run fallback
: "${NEXT:=${WALLS[0]}}"

# Save state
echo "$NEXT" > "$STATE_FILE"

# Set wallpaper
swww img "$NEXT" \
    --transition-type any \
    --transition-duration 1

# Generate colors
rm -rf ~/.cache/wal/*
wal -i "$NEXT" -n 
~/.config/hypr/scripts/wal-hyprland.sh

# Reload apps
pkill waybar
waybar
kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf 2>/dev/null
notify-send "Wallpaper" "Changing to:\n$(<"$STATE_FILE")"
pkill mako && mako &