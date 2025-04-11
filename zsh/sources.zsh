# Start starship
eval "$(starship init zsh)"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Source hellwal colors
source ~/.cache/hellwal/variables.sh
sh ~/.cache/hellwal/terminal.sh

# Custom plugin function, defined in function.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
