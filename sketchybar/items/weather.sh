#!/bin/sh

sketchybar --add item weather right \
  --set weather \
  icon=󰖐 \
  script="$PLUGIN_DIR/weather.sh" \
  update_freq=1500 \
  --subscribe weather mouse.clicked

sketchybar --add item weather.moon right \
    --set weather.moon \
    background.color=0xff8a2be2 \
    background.drawing=on \
    icon.color=0xff181926 \
    icon.font="$FONT:Bold:22.0" \
    icon.padding_left=4 \
    icon.padding_right=3 \
    label.drawing=off \
    --subscribe weather.moon mouse.clicked

