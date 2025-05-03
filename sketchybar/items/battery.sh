#!/bin/sh

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  padding_right=3
  padding_left=0
  #label.drawing=off
  update_freq=120
  updates=on
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
)
sketchybar --add item battery right \
           --set battery "${battery[@]}" \
              icon.font.size=15 update_freq=120 script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery power_source_change system_woke

