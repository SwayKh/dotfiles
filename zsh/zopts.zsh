ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999999'
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt interactive_comments
setopt extendedglob
setopt nomatch
setopt menucomplete
setopt LIST_PACKED
setopt LIST_ROWS_FIRST

unsetopt MENU_COMPLETE
unsetopt AUTO_MENU

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Remove duplicates from $PATH
typeset -U PATH
