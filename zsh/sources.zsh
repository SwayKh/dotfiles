# Custom plugin function, defined in function.zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

source "$HOME/.config/river/environment.sh"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# Start starship
eval "$(starship init zsh)"
