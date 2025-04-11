export LANG=en_US.UTF-8
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:"$HOME/.cargo/bin"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'
export SUDO_EDITOR=nvim

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

[ -z "$TMUX" ] && export TERM=xterm-256color

# Use fd instead of find
export FZF_DEFAULT_COMMAND='\
  fd -L -c never \
  --strip-cwd-prefix \
  --hidden \
  --no-ignore \
  --exclude .git \
  --ignore-file ~/home.gitignore\
  '

export FZF_DEFAULT_OPTS="\
  --ansi \
  --sort \
  --layout=default \
  --bind='ctrl-c:abort' \
  --bind='ctrl-b:preview-page-up' \
  --bind='ctrl-f:preview-page-down' \
  --bind='ctrl-u:preview-half-page-up' \
  --bind='ctrl-d:preview-half-page-down' \
  "

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_CTRL_T_OPTS="\
  --border=rounded \
  --preview-window=65% \
  --preview '~/scripts/preview.sh {}' \
  "
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_ALT_C_OPTS=$FZF_CTRL_T_OPTS
