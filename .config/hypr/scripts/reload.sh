killall waybar
pulseaudio -k

waybar &
pulseaudio --start

hyprctl reload
