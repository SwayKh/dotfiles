lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
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

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim
[ -z "$TMUX" ] && export TERM=xterm-256color

alias pokescript='pokemon-colorscripts -r'
alias color='colorscript -r'
alias pipes='pipes.sh'
alias vim='nvim'
alias :q='exit'
alias lf=lfcd
alias pm="sudo pacman"
alias yeet="sudo pacman -Rns"
alias up='paru -Syu'
alias lg='lazygit'
alias ls='eza -alh --color=always --group-directories-first'
alias pyActivate='source $HOME/Projects/Python/venv/bin/activate'
alias androidfs='sshfs -o follow_symlinks,IdentityFile=/home/sumit/.ssh/id_rsa u0a533@192.168.29.199:/data/data/com.termux/files/home/storage/shared/ -p 8022 /home/sumit/Android'

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
source /usr/share/nvm/init-nvm.sh
# (cat ~/.cache/wal/sequences &)

# This needs to be defined in root user.
#  recovery-pacman() {
#     pacman "$@"  \
#     --log /dev/null   \
#     --noscriptlet     \
#     --dbonly          \
#     --overwrite "*"   \
#     --nodeps          \
#     --needed
# }

# neofetch
# pokemon-colorscripts -r
# pfetch
# colorscript -r


# Remove duplicates from $PATH
typeset -U PATH

check_history(){
  awk -F ";" '{print $2}' $HISTFILE | grep "$1" | tac | bat
}

convertToJpg(){
  find . -name "*.png" -exec mogrify -format jpg {} \;
  find . -name "*.png" -exec rm {} \;
  find . -name "*.webp" -exec mogrify -format jpg {} \;
  find . -name "*.webp" -exec rm {} \;
  find . -type f -name "*.jpg" -exec convert {} -resize 2560x1440 -quality 90 {} \;
}

updateRom() {
  sudo mount -t auto -v /dev/sda3 /mnt/Roms
  sudo rsync -avhP ~/Roms/ /mnt/Roms/
  tree -L 2 ~/Roms/ > ~/Obsidian/Vault/Archive/RomsList.md
}
turnWifi(){
  sudo ip link set wlo1 down
  sudo iw wlo1 set type managed
  sudo ip link set wlo1 up
}

refreshMirrors() {
  sudo reflector --verbose --latest 15 --fastest 15 --age 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
}

cheatSheet() {
  query=$1
  curl cheat.sh/$query
}

clearNeofetch() {
  clear && neofetch
}

fzfconf() {
  find ~/dotfiles ~/scripts \
    -maxdepth 3 \
    -type f \
    -not -path '*/foot/themes/*' \
    -not -path '*/.git/*' \
    | fzf --cycle --border=rounded --preview 'bat $LINES {}' \
    | xargs -r -o nvim
}

mostUsed() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n"$1"
}

pacPreviewAll() {
  pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse
}

pacPreviewInstalled() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}
