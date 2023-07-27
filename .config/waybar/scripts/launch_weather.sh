#!/bin/sh

kitty --title weather sh -c "curl 'https://wttr.in/Salima+Lebanon' && read -p 'Press Enter to continue'" 
#hyprctl dispatch movetoworkspace empty
