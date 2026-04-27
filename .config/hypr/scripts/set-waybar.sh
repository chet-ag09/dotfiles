#!/bin/bash

THEME=$1
CONFIG_DIR="$HOME/.config/waybar"
THEME_DIR="$CONFIG_DIR/$THEME"

if [ -d "$THEME_DIR" ]; then
  cp "$THEME_DIR/config.jsonc" "$CONFIG_DIR/config.jsonc"
  cp "$THEME_DIR/style.css" "$CONFIG_DIR/style.css"
  pkill waybar && waybar & # Kill the current process and start a new one
else
  notify-send "Error: Theme directory not found: $THEME_DIR"
fi