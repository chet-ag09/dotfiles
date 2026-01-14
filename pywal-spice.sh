#!/bin/bash

# pywal colors file
walfile="$HOME/.cache/wal/colors.json"

# spicetify theme directory
theme_dir="$HOME/.config/spicetify/Themes/pywal-spice"

# create theme dir if not exists
mkdir -p "$theme_dir"

# extract colors (remove # for spicetify)
bg=$(jq -r '.colors.color0' "$walfile" | sed 's/#//')
bg_alt=$(jq -r '.colors.color1' "$walfile" | sed 's/#//')
fg=$(jq -r '.colors.color7' "$walfile" | sed 's/#//')
accent=$(jq -r '.colors.color2' "$walfile" | sed 's/#//')
accent_alt=$(jq -r '.colors.color3' "$walfile" | sed 's/#//')
secondary=$(jq -r '.colors.color4' "$walfile" | sed 's/#//')
highlight=$(jq -r '.colors.color5' "$walfile" | sed 's/#//')
notification=$(jq -r '.colors.color6' "$walfile" | sed 's/#//')

# write spicetify color.ini
cat > "$theme_dir/color.ini" <<EOF
[Colors]
background=$bg
background-alt=$bg_alt
text=$fg
subtext=$secondary
button=$accent
button-active=$accent_alt
button-disabled=$secondary
sidebar=$bg
sidebar-text=$fg
card=$bg_alt
shadow=$bg
selected-row=$highlight
notification=$notification
notification-error=$accent_alt
misc=$accent
EOF
