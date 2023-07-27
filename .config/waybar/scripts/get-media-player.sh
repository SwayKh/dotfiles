#!/bin/sh

player=$(playerctl --player=io,com,spotify,firefox,%any metadata --format '{{playerName}}')
class=""

if [[ $player =~ "io" ]]; then
	class=$(hyprctl clients -j | jq -r '.[] | select(.class | startswith("io")).class')
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
elif [[ $player =~ "com" ]]; then
	class=$(hyprctl clients -j | jq -r '.[] | select(.class | startswith("com")).class')
	player_name=$(echo $class | grep -oE '[^. ]+$' | awk '{print tolower($0)}')
else
	class=$(hyprctl clients -j | jq --arg name $player -r '.[] | select(.class | ascii_downcase | startswith("$ARGS.named.name")).class')
	player_name=$player
fi

is_running=$(pgrep $player_name > /dev/null && echo 0)

echo $player

if [[ $is_running -eq 0 ]];then
	id=$(hyprctl clients -j | jq --arg name $player -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).workspace["id"]')
	echo "id is " $id
	class=$(hyprctl clients -j | jq --arg name $player -r '.[] | select(.class | ascii_downcase | contains($ARGS.named.name)).class')
	hyprctl dispatch workspace $id && echo "Moved to ${id}"
	hyprctl dispatch focuswindow $class && echo "Focused ${class}"
else
	$player_name
fi

#exec $player_name

