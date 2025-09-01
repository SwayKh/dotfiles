ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999999'
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS
setopt NOMATCH
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt CDABLE_VARS
setopt EXTENDED_GLOB

setopt LIST_PACKED
setopt LIST_ROWS_FIRST
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# Manual Auto completions
autoload -Uz compinit; compinit -C
zmodload zsh/complist
_comp_options+=(globdots)

# Completion menu options
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix true
zstyle ':completion:*' complete true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Remove duplicates from $PATH
typeset -U PATH
