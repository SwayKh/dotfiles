# Exports.zsh needs to sourced before functions.zsh to set some Env var
# And zopts need to sourced before vim.zsh to setup vim-keybinds

source "$HOME/.config/zsh/zopts.zsh"
source "$HOME/.config/zsh/exports.zsh"

source "$HOME/.config/zsh/function.zsh"
source "$HOME/.config/zsh/sources.zsh"
source "$HOME/.config/zsh/vim.zsh"
source "$HOME/.config/zsh/aliases.zsh"
