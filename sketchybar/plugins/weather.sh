#!/bin/bash

sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

# Get location info
IP=$(curl -s https://ipinfo.io/ip)
if [ -z "$IP" ]; then
  sketchybar --set $NAME label="Cannot get IP"
  exit 1
fi

LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)
if [ -z "$LOCATION_JSON" ]; then
  sketchybar --set $NAME label="Cannot get location"
  exit 1
fi

LOCATION="$(echo $LOCATION_JSON | jq '.city' | tr -d '"')"
REGION="$(echo $LOCATION_JSON | jq '.region' | tr -d '"')"
COUNTRY="$(echo $LOCATION_JSON | jq '.country' | tr -d '"')"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?0pq&format=j1")
echo $WEATHER_JSON

# Fallback if empty
if [ -z "$WEATHER_JSON" ]; then
  sketchybar --set $NAME label="$LOCATION"
  sketchybar --set $NAME.moon icon=
  return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_F' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')
MOON_PHASE=$(echo $WEATHER_JSON | jq '.weather[0].astronomy[0].moon_phase' | tr -d '"')
echo $TEMPERATURE
echo $WEATHER_DESCRIPTION
echo $MOON_PHASE


case ${MOON_PHASE} in
"New Moon")
    ICON=
    ;;
"Waxing Crescent")
    ICON=
    ;;
"First Quarter")
    ICON=󰽡
    ;;
"Waxing Gibbous")
    ICON=
    ;;
"Full Moon")
    ICON=
    ;;
"Waning Gibbous")
    ICON=󰽦
    ;;
"Last Quarter")
    ICON=󰽣
    ;;
"Waning Crescent")
    ICON=󰽥
    ;;
esac

echo "Selected Icon: $ICON" >> /tmp/weather_debug.log

sketchybar --set $NAME label="$LOCATION  $TEMPERATURE°F $WEATHER_DESCRIPTION"
sketchybar --set $NAME.moon icon=$ICON

