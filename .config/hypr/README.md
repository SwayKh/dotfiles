## Installation

#### Base Arch Install - 
`base base-devel linux linux-lts linux-firmware grub amd-ucode ntfs-3g os-prober vim ufw`

#### Some tools, utilities needed for Hyprland to function are
```
wayland
hyprland-git 
rofi-lbonn-wayland 
waybar-hyprland-git 
hyprpaper 
hyprpicker 
xdg-desktop-portal-hyprland
swaybg 
ly 
playerctl 
brightnessctl 
pamixer 
wireplumber 
pipewire 
pulseaudio 
pulseaudio-bluetooth 
pavucontrol
dunst 
networkmanager 
network-manager-applet 
blueman 
feh 
cliphist 
wl-clipboard 
kitty 
grim 
slurp 
swaylock-effects 
swayidle 
qt6-wayland 
polkit-kde-agent 
ffmpegthumbnailer
```

#### Important Apps - 
```
firefox 
obsidian 
neovim 
micro 
nano 
visual-studio-code 
lf 
zsh 
bat 
fzf 
git 
curl 
wget 
tldr 
pacman-contrib 
gparted 
net-tool 
github-cli 
openssh 
sshfs 
zathura-pdf-mupdf 
man 
neofetch 
unzip 
unrar 
qt5ct 
lxappearance 
python-pip 
python-pipx
```

#### Extras (Install as needed)- 
```
thunar 
btop 
exa 
vnstat 
ripgrep 
tldr 
tree 
ncdu 
raindrop 
godot 
google-chrome 
citra 
retroarch 
yuzu 
gimp 
tiled 
cava 
cbonsai 
aseprite 
pfetch 
fuzzel 
strace 
shell-color-script 
marktext 
tty-clock 
powertop
```

## Details about the utilities
**Hyprland** - Window Manager. Very beautiful, customisable, and configurable Window manger. Has great animation. Very powerful key binding support.
**Hyprpaper** - Wallpaper utility for Hyprland. Swaybg is better.
**Hyprpicker** - Color picker for Hyprland. keybind in hyprland.conf
**Waybar** - Status bar, configuration is in the dotfiles. Use `waybar-hyprland-git` from the AUR for some hyprland patches like on-click active workspaces
**Rofi** - App Launcher, configuration are in dotfiles. Useful for creating menus for scripts. Use `rofi-lbonn-wayland` fork to use on wayland, the fork doesn't have window and dmenu mode.
**Swaybg** - Wallpaper utility, useful for setting up scripts. Can change wallpaper from the command line. Works great with Hyprland and Hyprpaper.
**Playerctl** - Software used for mapping functionality to the play, pause, next, previous Fn buttons.
**BrightnessCtl** - Software used to change screen brightness.
**Pamixer, Pavucontrol** - Utility to control Pulseaudio and used for changing Volume.
**Dunst** - Notification Daemon. Can be used in script
**Network-manager-applet** - GTK status bar applet to control and connect to Wifi.
**Wl-Clipboard** - Clipboard utility for wayland. Similar to xclip for X11
**Cliphist** - Clipboard manager for wayland. Binding in the hypland binding.
**ly-dm** - TUI Login manger. Very light weight.
**Polkit-kde-agent** - The Utility that asks for password when doing tasks that require `sudo` privilege, via GUI.
**Wireplumber Pamixer Pipewire Pulseaudio** - Wayland audio managers. Needed for Hyprland.
**Blueman** - Bluetooth utility. Can be used as applet similar to nm-applet
**Kitty** - Cross platform terminal. Works great, Very customisable, config is in dotfiles. Comes with useful plugins called kittens.
**Neofetch, pfetch** - System information utility.
**LF** - TUI File manager. Very customisable with shell scripting. Can integrate any/all CLI tools. config is in dotfiles.
**Grim** - Wayland Screenshot Utility. Takes screenshot of entire screen.
**Slurp** - Wayland screen area grabber. Works with Grim to take Screenshot of an area or window. Can be Keybound via Hyprland.
**Feh** - CLI Image viewer. Very lightweight. Not customisable, Can be configured via the Exec option is feh.desktop file in /usr/share/application.
**Zathura** - Lightweight PDF viewer. Install `zathura-pdf-mupdf` for pdf, docx support.
**Swaylock-effects** - Screen locking utility. config is in dotfiles. Different from swaylock, in the aur.
**Qt5ct, LxAppearance** - Theme changer and customiser for gtk and qt applications

## Audio not working?
Enable Pulseaudio service as a user, and `start` them
`systemctl --user enable pulseaudio.service`
`systemctl --user enable pulseaudio.socket`

## Chaning default applications
Change default text editor to nvim
`xdg-mime default nvim.desktop text/plain`

Change default image viewer to feh
`xdg-mime default feh.desktop image/png`
`xdg-mime default feh.desktop image/jpeg`
`xdg-mime default feh.desktop image/gif`

Change default Directory opener to LF
`xdg-mime default lf.desktop inode/directory`

Change default pdf viewer to Zathura
`xdg-mime default org.pwmt.zathura.desktop application/pdf`

Change default markdown view/editor to Mark-text
`xdg-mime default marktext.desktop text/markdown`
