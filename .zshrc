# Can't put this in ~/scripts/function.sh, The shell exits with lf
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || exit
  fi
}

export ZSH=$HOME/.oh-my-zsh
plugins=(git
    extract
    web-search
    yum
    git-extras
    docker
    vagrant
    zsh-autosuggestions)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999999'

source "$HOME"/scripts/function.sh
source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export EDITOR=nvim
export VISUAL=nvim
[ -z "$TMUX" ] && export TERM=xterm-256color

alias pokescript='pokemon-colorscripts -r'
alias color='colorscript -r'
alias pipes='pipes.sh'
alias c.='cd ~/dotfiles'
alias :q='exit'
alias lf=lfcd
alias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
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

eval "$(starship init zsh)"
# (cat ~/.cache/wal/sequences &)

# Remove duplicates from $PATH
typeset -U PATH
