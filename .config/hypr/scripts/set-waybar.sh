#!/bin/bash

CONFIG_DIR="$HOME/.config/waybar"
ACTIVE_CONFIG="$CONFIG_DIR/config.jsonc"
ACTIVE_STYLE="$CONFIG_DIR/style.css"
STATE_FILE="$CONFIG_DIR/.current_theme"

themes=()
for d in "$CONFIG_DIR"/*/; do
    dir_name=$(basename "$d")
    if [[ ! "$dir_name" =~ ^\. ]] && [ -f "${d}config.jsonc" ]; then
        themes+=("$dir_name")
    fi
done

IFS=$'\n' themes=($(sort <<<"${themes[*]}"))
unset IFS

if [ ${#themes[@]} -eq 0 ]; then
    notify-send "Waybar Error" "No theme folders found"
    exit 1
fi

current=$(tr -d '[:space:]' < "$STATE_FILE" 2>/dev/null)

index=-1
for i in "${!themes[@]}"; do
    if [[ "${themes[$i]}" == "$current" ]]; then
        index=$i
        break
    fi
done

next_idx=$(( (index + 1) % ${#themes[@]} ))
theme="${themes[$next_idx]}"

cp -f "$CONFIG_DIR/$theme/config.jsonc" "$ACTIVE_CONFIG"
cp -f "$CONFIG_DIR/$theme/style.css" "$ACTIVE_STYLE"

printf "%s" "$theme" > "$STATE_FILE"

pkill -x waybar
while pgrep -x waybar >/dev/null; do sleep 0.1; done
pkill -9 -x waybar 2>/dev/null

waybar -c "$ACTIVE_CONFIG" -s "$ACTIVE_STYLE" & disown

notify-send "Waybar" "Theme: $theme"