#!/bin/bash

python "$HOME/pychrome/pychrome.py"

pkill chromium

# found ts on reddit wtf
setsid chromium \
--user-data-dir="$HOME/.config/chromium" \
--load-extension="$HOME/pychrome" \
>/dev/null 2>&1 &