source "$HOME/.config/zsh/function.zsh"
source "$HOME/.config/zsh/zopts.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/exports.zsh"

# sources.zsh needs function.zsh to be loaded to call the plugin function
# And zopts need to sourced before vim.zsh to setup vim-keybinds
source "$HOME/.config/zsh/sources.zsh"
source "$HOME/.config/zsh/vim.zsh"

export PATH=$PATH:/home/sumit/.spicetify
