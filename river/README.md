# River

---

River is lightweight and interesting Wayland Compositor written in zig
River is a dynamic tiling Wayland compositor with flexible runtime configuration.

This Repository contains my RiverWM config, along with details about all
programs required to make it work

### Software

- WM/Compositor: River
- Terminal: foot
- File Manager: lf / (Recently switched to yazi)
- Browser: floorp
- Launcher: Rofi-wayland
- Editor: Neovim
- Bar: Waybar
- Idle Daemon: Swayidle
- Lock Screen: Swaylock-effects
- Notification Daemon: dunst
- Wallpaper: Swww
- Image Viewer: feh
- Document Viewer: zathura
- Clipboard: wl-clipboard
- Clipboard Manager: Cliphist
- Screenshots: Grim + Slurp
- Terminal Multiplexer: Tmux
- Bluetooth: blueman
- Wifi: NetworkManager + nm-applet
- Calculator: galculator
- Audio: Pipewire + Pamixer

# Installation

### Very important

```
sudo pacman -S xdg-desktop-portal-wlr brightnessctl playerctl polkit-gnome
```

### Utilities

```
sudo pacman -S --needed river foot rofi-wayland dunst waybar swayidle swww feh zathura grim slurp blueman nm-applet wl-clipboard cliphist wlr-randr
```

### Cli tools

```
sudo pacman -S --needed neovim fzf eza bat btop fd ripgrep lazygit tmux
```

### Pipewire and stuff

```
sudo pacman -S pipewire wireplumber pamixer pipewire-pulse pipewire-audio
```

#### From AUR

```
paru -S swaylock-effects lswt
```
