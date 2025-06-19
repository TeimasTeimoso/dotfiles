#!/usr/bin/env bash

# Author: Jesse Mirabel (@sejjy)
# GitHub: https://github.com/sejjy/mechabar

# Modified by: Ruben Teimas (@TeimasTeimoso)

# rofi config
config="$HOME/.config/rofi/bluetooth-menu.rasi"

# rofi window override
override_disabled="mainbox { children: [ textbox-custom, listview ]; } listview { lines: 1; padding: 6px 6px 8px; }"

get_device_icon() {
  local device_mac=$1
  device_info=$(bluetoothctl info "$device_mac")
  device_icon=$(echo "$device_info" | grep "Icon:" | awk '{print $2}')

  case "$device_icon" in
  "audio-headphones" | "audio-headset") echo "󰋋 " ;; # Headphones
  "video-display" | "computer") echo "󰍹 " ;;         # Monitor
  "audio-input-microphone") echo "󰍬 " ;;             # Microphone
  "input-keyboard") echo "󰌌 " ;;                     # Keyboard
  "audio-speakers") echo "󰓃 " ;;                     # Speakers
  "input-mouse") echo "󰍽 " ;;                        # Mouse
  "phone") echo "󰏲 " ;;                              # Phone
  *)
    echo "󰂱 " # Default
    ;;
  esac
}

get_paired_devices() {
  bluetoothctl devices | while read -r line; do
    device_mac=$(echo "$line" | awk '{print $2}')
    device_name=$(echo "$line" | awk '{$1=$2=""; print substr($0, 3)}')
    icon=$(get_device_icon "$device_mac")
    echo "$icon $device_name"
  done
}

connect_device() {
      local device_mac="$1"
      local device_name="$2"
      bluetoothctl trust "$device_mac" >/dev/null 2>&1
      bluetoothctl pair "$device_mac" >/dev/null 2>&1
      bluetoothctl connect "$device_mac" &
      sleep 3
      connection_status=$(bluetoothctl info "$device_mac" | grep "Connected:" | awk '{print $2}')
      if [[ "$connection_status" == "yes" ]]; then
        notify-send "Connected to \"$device_name\"." -i "package-installed-outdated"
        exit
      else
        notify-send "Failed to connect to \"$device_name\"." -i "package-broken"
      fi
}

while true; do
  # Get list of paired devices
  bluetooth_devices=$(get_paired_devices)

  options=$(
    echo "󰏌  Scan for devices"
    echo "󰂲  Disable Bluetooth"
    echo "$bluetooth_devices"
  )
  option="󰂯  Enable Bluetooth"

  # Get Bluetooth status
  bluetooth_status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

  if [[ "$bluetooth_status" == "yes" ]]; then
    selected_option=$(echo -e "$options" | rofi -dmenu -i -selected-row 1 -config "${config}" -p " " || pkill -x rofi)
  else
    selected_option=$(echo -e "$option" | rofi -dmenu -i -selected-row 1 -config "${config}" -theme-str "${override_disabled}" -p " " || pkill -x rofi)
  fi

  # Exit if no option is selected
  if [ -z "$selected_option" ]; then
    exit
  fi

  # Actions based on selected option
  case "$selected_option" in
  *"Enable Bluetooth")
    notify-send "Bluetooth Enabled" -i "package-installed-outdated"
    rfkill unblock bluetooth
    bluetoothctl power on
    sleep 1
    ;;
  *"Disable Bluetooth")
    notify-send "Bluetooth Disabled" -i "package-broken"
    rfkill block bluetooth
    bluetoothctl power off
    exit
    ;;
  *"Scan for devices")
    # Scan bluetooth for 3 seconds
    (
      echo "scan on"
      sleep 2
      echo "scan off"
    ) | bluetoothctl > /dev/null

    available_devices=$(get_paired_devices)

    if [ -z "$available_devices" ]; then
      notify-send "No new devices found." -i "dialog-information"
      continue
    fi

    selected_device=$(echo -e "$available_devices" | rofi -dmenu -i -config "${config}" -p "Scan Results" || pkill -x rofi)

    if [ -n "$selected_device" ]; then
      device_name="${selected_device#* }"
      device_name="${device_name## }"
      device_mac=$(bluetoothctl devices | grep "$device_name" | awk '{print $2}')
      connect_device "$device_mac" "$device_name"
    fi
    ;;
  *)
    device_name="${selected_option#* }"
    device_name="${device_name## }"

    if [[ -n "$device_name" ]]; then
      device_mac=$(bluetoothctl devices | grep "$device_name" | awk '{print $2}')
      connect_device "$device_mac" "$device_name"
    fi
    ;;
  esac
done
