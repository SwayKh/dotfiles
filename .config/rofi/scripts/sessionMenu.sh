#!/usr/bin/env bash

uptime=$(uptime -p | sed -e 's/up //g')

# Rofi dmenu mode, -i make search case-insensitive, -l is the number of line
THEME="/home/sumit/.config/rofi/scripts/powerconfig.rasi"
rofi_command() {
  rofi -dmenu \
        -theme /home/sumit/.config/rofi/scripts/powerconfig.rasi \
        -i \ 
        -l 5 
}
shutdown="󰐥 | Shutdown" 
reboot=" | Restart"
lock=" | Lock"
suspend="󰤄 | Suspend"
logout="󰍂 | Logout" 

options="$shutdown\n$reboot\n$logout\n$suspend\n$lock"

chosen="$(echo -e "$options" | rofi_command)"
echo $chosen


