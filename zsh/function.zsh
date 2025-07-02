# Set plugin installation directory
ZCONF="$HOME/.local/share/zsh"

# Function to source files if they exist
source_file() {
  [ -f "$ZCONF/$1" ] && source "$ZCONF/$1"
}

# Plugin Manager function, credit to Chris@Machine
zplug() {
  PLUGIN_NAME="${1##*/}"
  if [ -d "$ZCONF/plugins/$PLUGIN_NAME" ]; then
    # For plugins
    source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    source_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$ZCONF/plugins/$PLUGIN_NAME" && zplug "$1"
  fi
}

uplug() {
  for dir in "$ZCONF/plugins"/*; do
    if [ -d "$dir/.git" ]; then
      echo "Updating $(basename "$dir")..."
      git -C "$dir" pull --quiet || echo "Failed to update $(basename "$dir")"
    fi
  done
}

# Can't put this in ~/scripts/function.sh, The shell exits with lf
lfcd_old() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || exit
  fi
}

lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")" || exit
}

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

# Package Manager
pm() {
  pacman -Slq |
    fzf -m --preview='pacman -Si {}' \
    --border=rounded \
    --margin=1% \
    --height 100% \
    --layout=reverse \
    --bind='enter:execute(echo "Selected: "{+}; sudo pacman -S {+})+abort'
}

# Pacman Preview Explicitly Installed
ppi() {
  pacman -Qeq |
    fzf -m --preview 'pacman -Qil {}' \
    --border=rounded \
    --margin=1% \
    --height 100% \
    --layout=reverse \
    --bind 'enter:execute(echo "Selected: "{+}; sudo pacman -Rns {+})+abort'
}

# Pacman Preview All Installed
ppa() {
  pacman -Qq |
    fzf -m --preview 'pacman -Qil {}' \
    --border=rounded \
    --margin=1% \
    --layout=reverse \
    --bind 'enter:execute(echo "Selected: "{+}; sudo pacman -Rns {+})+abort'
}

# Taken from a reddit post of fastfetch config
age() {
  birth_install=$(stat -c %W /)
  current=$(date +%s)
  time_progression=$((current - birth_install))
  days_difference=$((time_progression / 86400))
  echo $days_difference days
}

most_used() {
  cat "$HOME/.zsh_history" |
    awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' |
    grep -v "./" |
    column -c3 -s " " -t |
    sort -nr |
    nl |
    head -n "$1"
}

rename_directories() {
  for dir in "$1"/*; do
    if [ -d "$dir" ]; then
      file=$(basename "$dir"/*)
      dir_path=$(dirname "$dir")
      mv "$dir" "$dir_path/$file"
      echo "Renamed '$dir' to '$dir_path/$file'"
    fi
  done
}

# This needs to be defined in root user.
#  recovery-pacman() {
#     pacman "$@"  \
#     --log /dev/null   \
#     --noscriptlet     \
#     --dbonly          \
#     --overwrite "*"   \
#     --nodeps          \
#     --needed
# }
