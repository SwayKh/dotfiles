export ZSH=$HOME/.oh-my-zsh
plugins=(git
    extract
    web-search
    yum
    git-extras
    # docker
    vagrant
    zsh-autosuggestions)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999999'
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

source "$HOME"/dotfiles/scripts/function.sh
source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim
[ -z "$TMUX" ] && export TERM=xterm-256color

export FZF_DEFAULT_OPTS="\
  --layout=reverse \
  --border \
  --height=50% \
  --preview-window=65% \
  --sort \
  --bind='ctrl-c:abort' \
  --bind='ctrl-b:preview-page-up' \
  --bind='ctrl-f:preview-page-down' \
  --bind='ctrl-u:preview-half-page-up' \
  --bind='ctrl-d:preview-half-page-down' \
  " # --inline-info
# Use fd instead of find
export FZF_DEFAULT_COMMAND='\
  fd --type f \
  --strip-cwd-prefix \
  --hidden \
  --exclude .git \
  --ignore-file ~/home.gitignore\
  '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --preview '~/scripts/preview.sh {}' \
  --height=50% \
  --preview-window=65% \
  "

alias pokescript='pokemon-colorscripts -r'
alias color='colorscript -r'
alias pipes='pipes.sh'
alias c.='cd ~/dotfiles'
alias :q='exit'
alias lf=lfcd
alias yazi=yy
alias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias fvim='fzf --print0 | xargs -0 -o nvim'
alias lg=lazygit
alias yeet="sudo pacman -Rns"
alias up='paru -Syu'
alias cleanfetch='clear && neofetch'
alias pyActivate='source $HOME/Projects/Python/venv/bin/activate'
alias androidfs='sshfs -o follow_symlinks,IdentityFile=/home/sumit/.ssh/id_rsa u0a533@192.168.29.199:/data/data/com.termux/files/home/storage/shared/ -p 8022 /home/sumit/Android'

alias ls='eza --all --icons=always --color=always --group-directories-first'
alias lt='eza --all --tree --color-scale --level=2 --icons=always --color=always --group-directories-first'
alias ll='eza -al --no-time --no-user --no-permissions --no-filesize --icons=always --color=always --group-directories-first'
alias la='eza -alh --git --icons=always --color=always --group-directories-first'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias ga.='git add --all'
alias gc='git commit'
alias gl='git log --oneline'
alias gb='git checkout -b'
alias gd='git diff'
alias gp='git push'
alias gP='git pull'

eval "$(starship init zsh)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# (cat ~/.cache/wal/sequences &)

# Remove duplicates from $PATH
typeset -U PATH
