#! /bin/bash

path=$(pwd)

# HOME Directory
sudo ln -sfn $path/.config/.zshrc $HOME/.zshrc 
sudo ln -sfn $path/.config/.profile $HOME/.profile
sudo ln -sfn $path/.config/.bashrc $HOME/.bashrc

# .config Directory

[ -d $HOME/.config/btop ] && rm -rf $HOME/.config/btop
sudo ln -sfn $path/.config/btop $HOME/.config/

[ -d $HOME/.config/lf ] && rm -rf $HOME/.config/lf
sudo ln -sfn $path/.config/lf $HOME/.config/

[ -d $HOME/.config/nvim ] && rm -rf $HOME/.config/nvim
sudo ln -sfn $path/.config/nvim $HOME/.config/

[ -d $HOME/.config/micro ] && rm -rf $HOME/.config/micro
sudo ln -sfn $path/.config/micro $HOME/.config/


[ -d $HOME/.config/kitty ] && rm -rf $HOME/.config/kitty
sudo ln -sfn $path/.config/kitty $HOME/.config/

[ -d $HOME/.config/neofetch ] && rm -rf $HOME/.config/neofetch
sudo ln -sfn $path/.config/neofetch $HOME/.config/


[ -f $HOME/.config/retroarch/retroarch.cfg ] && rm -rf $HOME/.config/retroarch/retroarch.cfg
sudo ln -sfn $path/.config/retroarch.cfg $HOME/.config/retroarch/retroarch.cfg 

#sudo ln -sfn $path/.local/applications $HOME/.local/share/applications
