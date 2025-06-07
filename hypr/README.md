## Installation
Installed Hyprland And removed KDE Plasma
What I removed can be found in [[Removing Plasma]]

#### Base Arch Install - 
`base base-devel linux linux-lts linux-firmware grub amd-ucode ntfs-3g os-prober vim ufw git openssh rsync`

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
fwupd
playerctl 
brightnessctl 
pamixer 
wireplumber 
pipewire 
pipewire-pusle
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
firefox/Thorium
obsidian 
neovim 
micro 
nano 
foot
visual-studio-code 
lf 
chafa
zsh 
bat 
fzf 
curl 
wget 
tldr 
pacman-contrib 
docker
gparted 
net-tool 
github-cli 
gvfs
sshfs 
zathura-pdf-mupdf 
man 
neofetch 
zip
unzip 
unrar 
preload
qt5ct 
lxappearance 
nwg-look
kcalc
python-pip 
python-pipx
```

#### Extras (Install as needed)- 
```
thunar 
tumbler
btop 
eza 
vnstat 
ripgrep 
tree 
ncdu 
raindrop 
godot 
fdupes
Webcord
Font-manager
google-chrome 
citra 
retroarch 
yuzu 
dolphin-emu
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
**Fwupd** - a firmware daemon. Can check device for firmware update and upgrade them.
**Playerctl** - Software used for mapping functionality to the play, pause, next, previous Fn buttons.
**BrightnessCtl** - Software used to change screen brightness.
**Pamixer, Pavucontrol** - Utility to control Pulseaudio and used for changing Volume.
**Dunst** - Notification Daemon. Can be used in script
**Network-manager-applet** - GTK status bar applet to control and connect to Wifi.
**Wl-Clipboard** - Clipboard utility for wayland. Similar to xclip for X11
**Cliphist** - Clipboard manager for wayland. Binding in the hypland binding.
**ly-dm** - TUI Login manger. Very light weight.
**Polkit-kde-agent** - The Utility that asks for password when doing tasks that require `sudo` privilege, via GUI.
**Wireplumber Pamixer Pipewire Pipewire-pulse( or Pulseaudio )**  - Wayland audio managers. Needed for Hyprland.
**Blueman** - Bluetooth utility. Can be used as applet similar to nm-applet
**Kitty** - Cross platform terminal. Works great, Very customisable, config is in dotfiles. Comes with useful plugins called kittens.
**Foot** - Wayland terminal. written in C, very lightweight, quite customisable.
**Neofetch, pfetch** - System information utility.
**LF** - TUI File manager. Very customisable with shell scripting. Can integrate any/all CLI tools. config is in dotfiles.
**Grim** - Wayland Screenshot Utility. Takes screenshot of entire screen.
**Slurp** - Wayland screen area grabber. Works with Grim to take Screenshot of an area or window. Can be Keybound via Hyprland.
**Feh** - CLI Image viewer. Very lightweight. Not customisable, Can be configured via the Exec option is feh.desktop file in /usr/share/application.
**Zathura** - Lightweight PDF viewer. Install `zathura-pdf-mupdf` for pdf, docx support.
**Swaylock-effects** - Screen locking utility. config is in dotfiles. Different from swaylock, in the aur.
**Qt5ct, LxAppearance, nwg-look** - Theme changer and customiser for gtk and qt applications
**Preload** - A system service that monitors frequently used apps into RAM to make their start-up faster

## Audio not working?
Enable Pulseaudio service as a user, and `start` them
`systemctl --user enable pulseaudio.service`
`systemctl --user enable pulseaudio.socket`

## Thunar
Graphical File Manager in case you need it
Install `gvfs` to access the file systems on the computer like USB stick and Ventoy.
Also install `tumbler` for image and video thumbnails in thunar

## Godot 4
Godot 4 need `vulkan-radeon` to be installed, In case it doesn't run after the project select screen.

## Theming Hyprland
Standalone apps can be themed within themselves like 
- Kitty
- Firefox
- Btop
- Neovim
- VsCode
- Obsidian

Some apps require Manual Theming like `rofi and waybar Hyprland`

#### For Qt Applications
Install `Kvantum` and `qt5ct` to apply themes to qt apps

For `qt5ct` this ENV variable needs to be in the `/etc/environment` file
> `QT_QPA_PLATFORMTHEME=qt5ct`

Download themes from pling.com. Extract them anywhere.
Select the theme directory and install the kvantum theme and apply it with Kvantum.
Go to qt5ct select the widget kvantum and apply, maybe change the font.

#### For GTK Applications
Install `nwg-look` app from the AUR or install `lxappearance` from extra repo
Put the themes in `/usr/share/themes` directory. Inside nwg-look select the theme your installed.

That Should be It for the theming. Right Now I have the hyprland_kitty.png wallpaper.
Rofi and waybar have the Primary color #BBCCDD And GTK and Qt Apps have the nord theme.
And Kitty has Monokai theme Applied.


## Chaning default applications
Change default text editor to nvim
`xdg-mime default nvim.desktop text/plain`
OR
`xdg-mime default nvim.desktop text/*` for LF

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

## Swayidle
Put this in `.config/swayidle/config`
```bash
timeout 1800 'swaylock -f'
timeout 1805 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
before-sleep 'swaylock -f'
```

and use `exec-once=swayidle -w` in hyprland.conf

## LF
Previously I was using many small tools to get LF to work with image previews -

Like using horriblename's LF fork with sixel support
Using `chafa` for image preview
compiling ctpv-git fir the preview script
and setting various setting in lfrc to accomodate ctpv

BUT NOW, LF supports sixel graphic in-built, So I can use the CTPV preview script
with base lf
Just set `set sixel true` in lfrc, and Install `chafa`

I will soon update the lfInstall script
