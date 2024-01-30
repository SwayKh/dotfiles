#! /bin/bash

path=$(pwd)

# HOME Directory
sudo ln -sfn "$path"/.zshrc "$HOME"/.zshrc
sudo ln -sfn "$path"/.profile "$HOME"/.profile
sudo ln -sfn "$path"/.bashrc "$HOME"/.bashrc
sudo ln -sfn "$path"/starship.toml "$HOME"/.config/starship.toml
sudo ln -Sfn "$path"/settings.json "$HOME"/.config/Code/User/settings.json
# sudo ln -sfn "$path"/tmux/tmux.conf "$HOME"/.tmux.conf

# .config Directory

sudo ln -sfn "$path"/.local/share/applications "$HOME"/.local/share/

[ -d "$HOME"/.config/btop ] && rm -rf "$HOME"/.config/btop
sudo ln -sfn "$path"/btop "$HOME"/.config/

[ -d "$HOME"/.config/lf ] && rm -rf "$HOME"/.config/lf
sudo ln -sfn "$path"/lf "$HOME"/.config/

[ -d "$HOME"/.config/nvim ] && rm -rf "$HOME"/.config/nvim
sudo ln -sfn "$path"/nvim "$HOME"/.config/

[ -d "$HOME"/.config/micro ] && rm -rf "$HOME"/.config/micro
sudo ln -sfn "$path"/micro "$HOME"/.config/

[ -d "$HOME"/.config/kitty ] && rm -rf "$HOME"/.config/kitty
sudo ln -sfn "$path"/kitty "$HOME"/.config/

[ -d "$HOME"/.config/neofetch ] && rm -rf "$HOME"/.config/neofetch
sudo ln -sfn "$path"/neofetch "$HOME"/.config/

[ -d "$HOME"/.config/hypr ] && rm -rf "$HOME"/.config/hypr
sudo ln -sfn "$path"/hypr "$HOME"/.config/

[ -d "$HOME"/.config/waybar ] && rm -rf "$HOME"/.config/waybar
sudo ln -sfn "$path"/waybar "$HOME"/.config/

[ -d "$HOME"/.config/i3 ] && rm -rf "$HOME"/.config/i3
sudo ln -sfn "$path"/i3 "$HOME"/.config/

[ -d "$HOME"/.config/sway ] && rm -rf "$HOME"/.config/sway
sudo ln -sfn "$path"/sway "$HOME"/.config/

[ -d "$HOME"/.config/polybar ] && rm -rf "$HOME"/.config/polybar
sudo ln -sfn "$path"/polybar "$HOME"/.config/

[ -d "$HOME"/.config/rofi ] && rm -rf "$HOME"/.config/rofi
sudo ln -sfn "$path"/rofi "$HOME"/.config/

[ -d "$HOME"/.config/foot ] && rm -rf "$HOME"/.config/foot
sudo ln -sfn "$path"/foot "$HOME"/.config/

[ -d "$HOME"/.config/dunst ] && rm -rf "$HOME"/.config/dunst
sudo ln -sfn "$path"/dunst "$HOME"/.config/

[ -d "$HOME"/.config/tmux ] && rm -rf "$HOME"/.config/tmux
sudo ln -sfn "$path"/tmux "$HOME"/.config/

[ -d "$HOME"/.config/wezterm ] && rm -rf "$HOME"/.config/wezterm
sudo ln -sfn "$path"/wezterm "$HOME"/.config/

[ -d "$HOME"/.config/swaylock ] && rm -rf "$HOME"/.config/swaylock
sudo ln -sfn "$path"/swaylock "$HOME"/.config/

[ -d "$HOME"/.config/swayidle ] && rm -rf "$HOME"/.config/swayidle
sudo ln -sfn "$path"/swayidle "$HOME"/.config/

[ -f "$HOME"/.config/retroarch/retroarch.cfg ] && rm "$HOME"/.config/retroarch/retroarch.cfg
sudo ln -sfn "$path"/RetroArch/retroarch.cfg "$HOME"/.config/retroarch/retroarch.cfg

[ -f "$HOME"~/.config/retroarch/retroarch-core-options.cfg ] && rm "$HOME"/.config/retroarch/retroarch-core-options.cfg
sudo ln -sfn "$path"/RetroArch/retroarch-core-options.cfg "$HOME"/.config/retroarch/retroarch-core-options.cfg
