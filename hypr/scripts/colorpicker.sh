#! /usr/bin/env bash

color=$(hyprpicker)

if [ -z "$color" ]; then
  notify-send "No color selected."
  exit 1
fi

echo -n "$color" | wl-copy

notify-send "Color: $color"
