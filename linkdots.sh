#! /bin/bash

path=$(pwd)

# HOME Directory
sudo ln -sfn $path/.config/.zshrc $HOME/.zshrc
sudo ln -sfn $path/.config/.profile $HOME/.profile
sudo ln -sfn $path/.config/.bashrc $HOME/.bashrc
sudo ln -sfn $path/.config/starship.toml $HOME/.config/starship.toml

# .config Directory

[ -d $HOME/.config/btop ] && rm -rf $HOME/.config/btop
sudo ln -sfn $path/.config/btop $HOME/.config/

[ -d $HOME/.config/lf ] && rm -rf $HOME/.config/lf
sudo ln -sfn $path/.config/lf $HOME/.config/

[ -d $HOME/.config/ctpv/ ] && rm -rf $HOME/.config/ctpv
sudo ln -sfn $path/.config/ctpv $HOME/.config/

[ -d $HOME/.config/nvim ] && rm -rf $HOME/.config/nvim
sudo ln -sfn $path/.config/nvim $HOME/.config/

[ -d $HOME/.config/micro ] && rm -rf $HOME/.config/micro
sudo ln -sfn $path/.config/micro $HOME/.config/

[ -d $HOME/.config/kitty ] && rm -rf $HOME/.config/kitty
sudo ln -sfn $path/.config/kitty $HOME/.config/

[ -d $HOME/.config/neofetch ] && rm -rf $HOME/.config/neofetch
sudo ln -sfn $path/.config/neofetch $HOME/.config/

[ -d $HOME/.config/hypr ] && rm -rf $HOME/.config/hypr
sudo ln -sfn $path/.config/hypr $HOME/.config/

[ -d $HOME/.config/waybar ] && rm -rf $HOME/.config/waybar
sudo ln -sfn $path/.config/waybar $HOME/.config/

[ -d $HOME/.config/rofi ] && rm -rf $HOME/.config/rofi
sudo ln -sfn $path/.config/rofi $HOME/.config/

[ -d $HOME/.config/foot ] && rm -rf $HOME/.config/foot
sudo ln -sfn $path/.config/foot $HOME/.config/

[ -d $HOME/.config/swaylock ] && rm -rf $HOME/.config/swaylock
sudo ln -sfn $path/.config/swaylock $HOME/.config/

[ -d $HOME/.config/swayidle ] && rm -rf $HOME/.config/swayidle
sudo ln -sfn $path/.config/swayidle $HOME/.config/

[ -f $HOME/.config/retroarch/retroarch.cfg ] && rm -rf $HOME/.config/retroarch/retroarch.cfg
sudo ln -sfn $path/.config/retroarch.cfg $HOME/.config/retroarch/retroarch.cfg
