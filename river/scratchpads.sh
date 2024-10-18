#! /usr/bin/env bash
#
# Riverctl script to open scratchpads, and open programs if Scratchpads are
# empty. Usage "./scratchpads.sh <term|btop|lf|nvim>"
#

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Error: No argument provided."
  exit 1
fi

terminal="footclient"
terminal_tag=$((1 << 11))
files_tag=$((1 << 12))
dots_tag=$((1 << 13))
monitor_tag=$((1 << 14))

term="$terminal --app-id special-term -e zsh -ic \"tmux new-session -s Terminal\""
btop="$terminal --app-id special-btop -e btop"
nvim="$terminal --app-id special-nvim --working-directory=$HOME/dotfiles/ -e zsh -ic \"tmux new-session -s Editor 'nvim'\""
files="$terminal --app-id special-files -e zsh -ic yazi"

case "$1" in
"term")
  search="special-term"
  tag="$terminal_tag"
  cmd="$term"
  ;;
"files")
  search="special-files"
  tag="$files_tag"
  cmd="$files"
  ;;
"btop")
  search="special-btop"
  tag="$monitor_tag"
  cmd="$btop"
  ;;
"nvim")
  search="special-nvim"
  tag="$dots_tag"
  cmd="$nvim"
  ;;
esac

if lswt | grep -q "$search"; then
  riverctl set-focused-tags "$tag"
else
  riverctl spawn "$cmd"
  riverctl set-focused-tags "$tag"
fi
