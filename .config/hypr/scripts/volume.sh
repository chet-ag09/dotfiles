#!/bin/bash

STEP=5
ID=9991

case "$1" in
  up)
    pamixer -i $STEP
    VOL=$(pamixer --get-volume)
    notify-send -r $ID -h int:value:$VOL "Volume" "${VOL}%"
    ;;
  down)
    pamixer -d $STEP
    VOL=$(pamixer --get-volume)
    notify-send -r $ID -h int:value:$VOL "Volume" "${VOL}%"
    ;;
  mute)
    pamixer -t
    if pamixer --get-mute; then
      notify-send -r $ID "Volume" "Muted"
    else
      VOL=$(pamixer --get-volume)
      notify-send -r $ID -h int:value:$VOL "Volume" "${VOL}%"
    fi
    ;;
esac
