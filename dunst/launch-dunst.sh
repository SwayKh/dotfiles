#!/usr/bin/env bash

source "$HOME/.cache/hellwal/variables.sh"

conf="$HOME/.config/dunst/dunstrc"

# update dunst colors on hellwal colors.
sed -i '/background = /s|.*|    background = "#'"$color8"'"|' "$conf"
sed -i '/foreground = /s|.*|    foreground = "#'"$color6"'"|' "$conf"
sed -i '/frame_color = /s|.*|    frame_color = "#'"$color6"'"|' "$conf"

pkill dunst && dunst &
