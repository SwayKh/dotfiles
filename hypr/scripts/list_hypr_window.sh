#! /usr/bin/env bash
#
# Send notification of active open windows and workspaces via hyprctl.
# Better than checking all active workspaces
#
#
notify-send "$(hyprctl clients |
  grep -E "workspace:|class:" |
  grep -i -v "title:" |
  grep -i -v "window" |
  sed 's/^[ \t]*//' |
  sed 's/:.*(/: (/g' |
  sed 's/class://g' |
  paste -d, - - |
  sort |
  awk -F', ' '{print $2 ", " $1}')"
