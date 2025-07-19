# Aliases
alias c.='cd ~/dotfiles'
alias :q='exit'
alias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias fvim='fzf --print0 | xargs -0 -o -r nvim'
alias yeet="sudo pacman -Rns"
alias up='paru -Syu'
alias venv='source $HOME/venv/bin/activate'
alias serve='python -m http.server'

alias androidfs='sshfs -o follow_symlinks,IdentityFile=/home/sumit/.ssh/id_rsa u0a533@192.168.29.199:/data/data/com.termux/files/home/storage/shared/ -p 8022 /home/sumit/Android'

# confirm before overwriting something
alias cp="cp -i -v"
alias mv='mv -i -v'
alias rm='rm -i -v'

# Program Aliases
alias v=nvim
alias pokescript='pokemon-colorscripts -r'
alias color='colorscript -r'
alias pipes='pipes.sh -R -p 4 -t 0'
alias cleanfetch='clear && fastfetch'
alias cls='cleanfetch'
alias lf=lfcd
alias yazi=y
alias lg=lazygit
alias hw='hellwal --no-cache -i $HOME/.config/wall.png --bright-offset 0.3'
alias pw='wal -n -e -a 80 -i $HOME/.config/wall.png && swaync-client -rs'

# cd Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# eza Aliases
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
