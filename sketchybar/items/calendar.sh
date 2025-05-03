#!/bin/bash

calendar=(
  icon=􀐫
  icon.font="$FONT:Black:12.0"
  icon.padding_right=0
  label.align=right
  padding_left=15
  update_freq=30
  icon.highlight_color=$RED
  icon.padding_left=10
  icon.padding_right=10
  padding_left=2
  padding_right=2
  label.padding_right=20
  label.color=$GREY
  label.highlight_color=$WHITE
  label.y_offset=-1
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
