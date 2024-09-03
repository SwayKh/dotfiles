#! /usr/bin/env bash

color=$(hyprpicker)

echo -n "$color" | wl-copy

dunstify "Color: $color"
