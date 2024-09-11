```
 ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
 ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
 ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
 ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
 ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
 ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

---

## What Software I use

---

- **OS** : [Arch](https://archlinux.org/)
- **WM/Compositor** : [Hyprland](https://hyprland.org/) / [River](https://codeberg.org/river/river)
- **Bar** : [Waybar](https://github.com/Alexays/Waybar)
- **Application Launcher** : [Rofi(wayland fork)](https://github.com/lbonn/rofi)
- **Terminal** : [Foot](https://codeberg.org/dnkl/foot)
- **File Manager** : [LF](https://github.com/gokcehan/lf) / [Yazi](https://github.com/sxyazi/yazi)
- **File Manager(GUI)** : [Nautilus](https://apps.gnome.org/Nautilus/)
- **Text Editor** : [Neovim](https://neovim.io/)
- **Browser** : [Floorp](https://floorp.app/en)
- **Idle daemon** : [Hypridle](https://github.com/hyprwm/hypridle)
- **Screen Locking Utility** : [Hyprlock](https://github.com/hyprwm/hyprlock)
- **Terminal Multiplexer** : [Tmux](https://github.com/tmux/tmux)
- **Shell** : [Zsh](https://www.zsh.org/)
- **Shell Prompt** : [Starship](https://starship.rs/)
- **Login Manager** : [ly](https://github.com/fairyglade/ly)
- **Wallpaper Utility** : [Swww](https://github.com/LGFae/swww)
- **PDF Reader** : [Zathura](https://github.com/pwmt/zathura)
- **System Monitor** : [Btop](https://github.com/aristocratos/btop)
- **System Info viewer** : [Neofetch](https://github.com/dylanaraps/neofetch)
- **Notification daemon** : [Dunst](https://github.com/dunst-project/dunst)
- **Image Viewer** : [Feh](https://github.com/derf/feh)
- **Anime Client** : [Ani-cli](https://github.com/pystardust/ani-cli)
- **Local Sync Client** : [Syncthing](https://syncthing.net/)
- **Color Picker** : [Hyprpicker](https://github.com/hyprwm/hyprpicker)
- **Clipboard** : [wl-clipboard](https://github.com/bugaevc/wl-clipboard)
- **Screenshot**: [Grim+Slurp](https://sr.ht/~emersion/grim/)
- **Emulation Frontend** : [Retroarch](https://www.retroarch.com/) / [ES-DE](https://es-de.org/)
- **Customization** : [Nwg-look](https://github.com/nwg-piotr/nwg-look)
  / [Qt6ct](https://github.com/trialuser02/qt6ct)
- **Font** : JetBrainsMono Nerd Font
- [Scripts](https://github.com/swaykh/scripts)
- [Wallpapers](https://github.com/swaykh/wallpapers)

#### Alternatives to programs, or Xorg counterparts

- **Terminal** : [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Text Editor** : [Micro](https://micro-editor.github.io/)
- **File Manager(GUI)** : [Thunar](https://docs.xfce.org/xfce/thunar/start)
- **Screenlock Util** : [Swaylock-effects](https://github.com/mortie/swaylock-effects)
- **Idle daemon** : [Swayidle](https://github.com/swaywm/swayidle)
- **Notification daemon** : [Swaync](https://github.com/ErikReider/SwayNotificationCenter)
- **WM/Compositor** : [i3(X11)](https://i3wm.org/) / [Sway(Wayland replacement for i3)](https://swaywm.org/)
- **Bar(For X11)** : [Polybar](https://github.com/polybar/polybar)
- **Color Picker** : [xcolor](https://github.com/Soft/xcolor)
- **Wallpaper Utility** : [Swaybg](https://github.com/swaywm/swaybg)
- **Clipboard** : [xclip](https://github.com/astrand/xclip)

## Screenshot

---

![Screenshot](./img/screenshot.png)
![Neovim](./img/nvim.png)

These are all my dotfiles, even for the software I don't use anymore. Feel free
to copy and mix and match however you like, Most of this is taken from others'
configs. Some of it might even be the defaults.

The wallpapers can be found in my [Wallpapers](https://github.com/Swaykh/wallpapers) repo.
Most of these are taken from github repos and [Unixporn](https://reddit.com/r/unixporn)

The scripts I use for setting wallpapers and the Power Menu using rofi are in the
[scripts repo](https://github.com/swaykh/scripts)

## Installation

#### Important

```
sudo pacman -S xdg-desktop-portal-wlr brightnessctl playerctl polkit-gnome
```

#### Pipewire and stuff

```
sudo pacman -S pipewire wireplumber pamixer pipewire-pulse pipewire-audio
```

#### Hyprland Stuff

```
sudo pacman -S --needed hyprland hyprlock hypridle hyprpicker hyprcursor
```

#### Or River Stuff

```
paru -S river lswt swaylock-effects swayidle wlr-randr
```

#### Utilities

```
sudo pacman -S --needed floorp foot rofi-wayland dunst waybar nautilus sddm swayidle swww feh zathura grim slurp blueman nm-applet wl-clipboard cliphist
```

#### Cli tools

```
sudo pacman -S --needed zsh neovim fzf eza bat btop fd ripgrep lazygit tmux tldr starship lf cava jq ncdu sshfs swww
```

Follow these steps (Beware that this will remove all your old configs. So prepare a back-up beforehand)

>     git clone https://github.com/SwayKh/dotfiles.git
>     cd dotfiles
>     ./linkdots.sh

There's also some configs, I've kept as backup. For eg

> - [Retroarch Config](./retroarch.cfg)
> - [Old Vim Config](./init.vim.backup)
> - [KDE shortcuts file](./kde)
> - [VS Code Settings.json](./settings.json)
> - [Emulation Station DE](./ES-DE)

## Hyprland

My Hyprland Configs and keybinds. My hyprland config is divided into various
different conf files to make it easier to navigate. I'll put the list of
programs I have installed in a note to make it easier to setup or choose some
alternatives to use.

Swaylock and Swayidle can be replaced with Hyprlock and Hypridle for Hyprland

## River

Recently switched to River as my WM/Compositor, after using Hyprland for a year.
The River config is a single shell executable init file that contains all the
configuration. Will a environments.sh file that is source from my .zshrc and a
custom scratchpad.sh script that mimics hyprland's create-on-empty feature for
scratchpads/Special workspaces.

Dependencies required for River are listed above.

## Dependencies

Dependencies for LF Preview script or Yazi preview

```
bat
chafa
glow
wkhtmltopdf
ffmpegthumbnailer
ImageMagick
poppler
unarchiver
[epub-thumbnailer](https://github.com/marianosimone/epub-thumbnailer)
            or
epub-thumnailer-git in AUR
tar
xz
unzip
unrar
p7zip
```

Other Dependencies

```
fd (Telescope plugin neovim)
ripgrep (Telescope plugin neovim)
tumbler (For thumbnails in Thunar File Manager)
wmctrl (Window switching functionality for rofi-wayland-fork)
cliphist (Rofi as clipboard manager)
ripdrag (For drag and drop functionality in LF)
wlr-randr (For turning DPMS off when using River)
vulkan-radeon(Needed for Godot4)
fuse2 fuse3 gvfs ntfs-3g (Needed to view files on windows from linux/Mounting)
gvfs-mnt (Needed for mounting Phone storage via USB)
os-prober (Needed for add windows as boot entry in grub)
upower (Needed to check battery levels of pheripherals like controllers)
bluez-util (Needed xpadneo-dkms/Bluetooth controllers)
polkit-gnome (Needed for GUI Password prompt for root GUI apps)
perl-file-mimeinfo (Needed for using mimeopen command in lf)
qt-graphicaleffects (Needed for sddm theme)
qt-quickcontrols2 (Needed for sddm theme)
xdg-desktop-portal-hyprland (Needed for hyprland)
xdg-desktop-portal-gtk (Needed for gtk file pickers)
android-sdk-platform-tools (Needed for android build in Godot)
android-tools (Needed for android build in Godot)
python-pip/x
chaotic-keyring
chaotic-mirrorlist
Nerd Font (https://www.nerdfonts.com/)

go rust perl lua python nvm npm
wayland/x11
```

### List of programs installed(More like a pacman -Qeq)

#### Base programs to install with Arch

```
base base-devel linux linux-firmware linux-headers grub vim amd-ucode net-tools
git curl wget man-db pacman-contrib openssh networkmanager
efibootmgr
```

#### Apps

```
ani-cli
citra-canary
emulationstation-de
ferdium
firefox
foot
google-chrome
godot
gparted
kclac
kdeconnect
obsidian
qbittorrent
retroarch
rofi-nerdy
sddm
nautilus
ticktick
uget
vscode
webcord
yuzu
```

#### CLI

```
blueman
birghtnessctl
docker
fwupd
github-cli
pacutils
network-manager-applet
pamixer
pipewire
pipewire-audio
pipewire-pulse
wireplumber
pavucontrol
pulseaudio
playerctl
reflector
rsync
swaync
swww
ubsutils
xpadneo-dkms
```
