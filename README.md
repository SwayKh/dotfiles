     ____   ___ _____ _____ ___ _     _____ ____
    |  _ \ / _ |_   _|  ___|_ _| |   | ____/ ___|
    | | | | | | || | | |_   | || |   |  _| \___ \
    | |_| | |_| || | |  _|  | || |___| |___ ___) |
    |____/ \___/ |_| |_|   |___|_____|_____|____/
    
***



> *Still a work in progress*



## Installation
***


Run this (Beware that this will remove all your old configs. So Prepare a back-up beforehand)

>     git clone https://github.com/SumitKhatri712/dotfiles.git
>     cd dotfiles
>     ./linkdots.sh



## What does it contain?
***

I have put the following configs in the repo
> 
> - [.bashrc](.config/.bashrc)
> - [.zshrc](.config/.zshrc)
> - [Btop](.config/btop)
> - [Kitty](.config/kitty)
> - [LF Config](.config/lf)
> - [Neovim](.config/nvim)
> - [Neofetch](.config/neofetch)
> - [Micro](.config/micro)
> - [.profile](.config/.profile)
> 


### Neofetch
***

The neofetch config was taken from a user from [r/unixporn](reddit.com/r/unixporn) with a few minor changes. 


### [Pokemon-colorscripts](https://github.com/nuke-dash/pokemon-colorscripts-mac)
***

My .zshrc starts up with pokemon-colorscripts, So be sure to install it. Or remove it from .zshrc

    git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
    cd pokemon-colorscripts
    sudo ./install.sh
    pokemon-colorscripts



### LF File Manager
***

There is a custom LF install script that i made to install LF and setup my configs with it
You can find it in my [Scripts](https://github.com/SumitKhatri712/Scripts) repository

Some Requirements for using LF file manager
>  - Use a [Nerd Font](https://www.nerdfonts.com/)
>  - Compiling [ctpv](https://github.com/NikitaIvanovV/ctpv) which my scripts automatically does for you
>  - `ncdu` utility for check directory sizes


Dependencies for previews with ctpv
- ffmpegthumbnailer
- ImageMagick
- poppler
- epub-thumbnailer
- wkhtmltopdf
- chafa

For wayland Instructions check the ctpv repository
