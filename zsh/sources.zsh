# Start starship
eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Source pywal16 colors
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors.sh

# Custom plugin function, defined in function.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
