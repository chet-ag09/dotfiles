#!/bin/bash

STEP=5
ID=9992

case "$1" in
  up)
    brightnessctl set ${STEP}%+ >/dev/null
    ;;
  down)
    brightnessctl set ${STEP}%- >/dev/null
    ;;
  *)
    exit 1
    ;;
esac

BRIGHT=$(brightnessctl g)
MAX=$(brightnessctl m)
PERC=$(( BRIGHT * 100 / MAX ))

notify-send -r $ID -h int:value:$PERC "Brightness" " ${PERC}%"
