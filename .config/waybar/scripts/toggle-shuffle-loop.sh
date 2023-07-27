#!/bin/sh

if [[ $1 = "shuffle" ]]; then
	current=$(playerctl shuffle)
	if [[ $current == "Off" ]]; then
		playerctl shuffle on
	else
		playerctl shuffle off
	fi
	echo shuffled
elif [[ $1 = "loop" ]]; then 
	current=$(playerctl loop)
	if [[ $current =  "Playlist" ]]; then
		playerctl loop track
	elif [[ $current = "Track" ]]; then
		playerctl loop none
	elif [[ $current = "None" ]]; then
		playerctl loop playlist
	fi
	echo looped
fi
