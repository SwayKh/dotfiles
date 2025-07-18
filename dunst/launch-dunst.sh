#!/usr/bin/env bash

swaync-client -rs
source "$HOME/.cache/wal/colors.sh"

conf="$HOME/.config/dunst/dunstrc"

# update dunst colors on Pywal16 colors.
sed -i '/background = /s|.*|    background = "'$color2'"|' "$conf"
sed -i '/foreground = /s|.*|    foreground = "'$color0'"|' "$conf"
sed -i '/frame_color = /s|.*|    frame_color = "'$color0'"|' "$conf"

killall dunst
sleep 0.5
dunst &
