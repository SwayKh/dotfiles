# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/go/bin/:$PATH"
export PATH="$HOME/.local/kitty.app/bin/:$PATH"
export EDITOR=/usr/bin/micro
export VISUAL=/usr/bin/nvim

alias pokescript='pokemon-colorscripts -r'
# alias bat='batcat'
alias pipes='pipes.sh'
alias vim='nvim'
alias update='sudo pacman -Syu'
alias pyActivate='source $HOME/Projects/Python/venv/bin/activate'
alias androidfs='sudo sshfs -o allow_other,follow_symlinks u0_a533@192.168.29.135:/data/data/com.termux/files/home -p 8022 /mnt/Android/'

my_alias() {
    alias ls='exa -alh --color=always --group-directories-first'
}


source /usr/share/autojump/autojump.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
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

pokemon-colorscripts -r


# Remove duplicates from $PATH
typeset -U PATH

#Replace Apt with Nala
apt() {
    command nala "$@"
}
sudo() {
    if [ "$1" = "apt" ]; then
        shift
        command sudo nala "$@"
    else
        command sudo "$@"
    fi
}
my_alias
