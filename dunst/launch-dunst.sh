#!/usr/bin/env bash

source "$HOME/.cache/wal/colors.sh"

conf="$HOME/.config/dunst/dunstrc"

# update dunst colors on Pywal16 colors.
sed -i '/background = /s|.*|    background = "#'"$color8"'"|' "$conf"
sed -i '/foreground = /s|.*|    foreground = "#'"$color6"'"|' "$conf"
sed -i '/frame_color = /s|.*|    frame_color = "#'"$color6"'"|' "$conf"

pkill dunst && notify-send -t 500 "Wallpaper and colorscheme changed; setting RGB value"
