#!/usr/bin/env bash
 
echo "space_windows.sh started" >> /tmp/sketchybar.log
echo "AEROSPACE_PREV_WORKSPACE: $AEROSPACE_PREV_WORKSPACE" >> /tmp/sketchybar.log
echo "AEROSPACE_FOCUSED_WORKSPACE: $AEROSPACE_FOCUSED_WORKSPACE" >> /tmp/sketchybar.log
echo "SELECTED: $SELECTED" >> /tmp/sketchybar.log
echo "SENDER: $SENDER" >> /tmp/sketchybar.log
echo "NAME: $NAME" >> /tmp/sketchybar.log

source "$CONFIG_DIR/colors.sh"

AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
AEROSAPCE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
AEROSPACE_EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

echo "Focused monitor: $AEROSPACE_FOCUSED_MONITOR" >> /tmp/sketchybar.log
echo "Focused workspaces: $AEROSAPCE_WORKSPACE_FOCUSED_MONITOR" >> /tmp/sketchybar.log
echo "Empty workspaces: $AEROSPACE_EMPTY_WORKSPACE" >> /tmp/sketchybar.log

reload_workspace_icon() {
  echo "Reloading workspace icon for $1" >> /tmp/sketchybar.log
  apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --animate sin 10 --set space.$1 label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  echo "Handling workspace change" >> /tmp/sketchybar.log

  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  # current workspace space border color
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
                         label.highlight=true \
                         background.border_color=$GREY

  # prev workspace space border color
  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false \
                         label.highlight=false \
                         background.border_color=$BACKGROUND_2

  ## focused 된 모니터에 space 상태 보이게 설정
  for i in $AEROSAPCE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done

  for i in $AEROSPACE_EMPTY_WORKSPACE; do
    sketchybar --set space.$i display=0
  done

  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR

fi

echo "space_windows.sh finished" >> /tmp/sketchybar.log
