#!/bin/bash

killall waybar
pulseaudio -k
pulseaudio --start

waybar &

hyprctl reload
