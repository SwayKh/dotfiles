#!/bin/bash
wall=$(command ls ~/wallpapers/Favourites/ | shuf -n 1)
path="/home/sumit/wallpapers/Favourites/$wall"

cp "$path" ~/.config/wall.png && swaybg -m fill -i "$path" &
