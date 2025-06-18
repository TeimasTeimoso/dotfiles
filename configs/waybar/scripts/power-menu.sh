#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

actions=$(echo -e "  Lock\n  Reboot\n Shutdown\n Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" -no-lazy-grab -normal-window || pkill -x rofi)

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
  loginctl lock-session
  ;;
*Reboot)
  systemctl reboot
  ;;
*Shutdown)
  systemctl poweroff
  ;;
*Logout)
  loginctl kill-session "$XDG_SESSION_ID"
  ;;
esac
