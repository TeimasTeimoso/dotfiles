#!/usr/bin/env bash

# Original script by Eric Murphy
# https://github.com/ericmurphyxyz/dotfiles/blob/master/.local/bin/battery-alert
#
# Modified by Jesse Mirabel (@sejjy)
# https://github.com/sejjy/mechabar

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# get the battery state from the udev rule
BATTERY_STATE=$1

# get the battery percentage using upower (waybar dependency)
BAT_PATH=$(upower -e | grep BAT | head -n 1)
BATTERY_LEVEL=$(upower -i "$BAT_PATH" | awk '/percentage:/ {print $2}' | tr -d '%')

# set the battery charging state and icon
case "$BATTERY_STATE" in
"charging")
  BATTERY_CHARGING="Charging"
  BATTERY_ICON="090-charging"
  ;;
"discharging")
  BATTERY_CHARGING="Disharging"
  BATTERY_ICON="090"
  ;;
esac

# send the notification
notify-send -a "state" "Battery ${BATTERY_CHARGING} (${BATTERY_LEVEL}%)" -u normal -i "battery-${BATTERY_ICON}" -r 9991
