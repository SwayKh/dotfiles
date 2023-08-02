if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/go/bin/:$PATH"
export PATH="$HOME/.local/kitty.app/bin/:$PATH"
export EDITOR=nvim
# export VISUAL=micro

alias pokescript='pokemon-colorscripts -r'
# alias bat='batcat'
alias pipes='pipes.sh'
alias vim='nvim'
alias :q='exit'
alias pyActivate='source $HOME/Projects/Python/venv/bin/activate'
# alias androidfs='sudo sshfs -o allow_other,follow_symlinks u0_a533@192.168.29.199:/data/data/com.termux/files/home -p 8022 /mnt/Android/'
alias androidfs='sshfs -o follow_symlinks,IdentityFile=/home/sumit/.ssh/id_rsa u0a533@192.168.29.199:/data/data/com.termux/files/home/storage/shared/ -p 8022 /home/sumit/Android'
alias update='sudo pacman -Syu'

my_alias() {
    alias ls='exa -alh --color=always --group-directories-first'
}

check_history(){
  awk -F ";" '{print $2}' $HISTFILE | grep "$1" | bat 
}


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


plugins=(git
    extract
    web-search
    yum
    git-extras
    docker
    vagrant
    zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#neofetch
#pokemon-colorscripts -r
pfetch


# Remove duplicates from $PATH
typeset -U PATH

#Replace Apt with Nala
# apt() {
#     command nala "$@"
# }
# sudo() {
#     if [ "$1" = "apt" ]; then
#         shift
#         command sudo nala "$@"
#     else
#         command sudo "$@"
#     fi
# }
my_alias
