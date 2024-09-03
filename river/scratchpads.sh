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
lf_tag=$((1 << 12))
dots_tag=$((1 << 13))
monitor_tag=$((1 << 14))

term="$terminal --app-id special-term -e zsh -ic \"tmux new-session -s Terminal\""
lf="$terminal --app-id special-lf -e zsh -ic \"tmux new-session -s FileManager 'lf'\"" #lfMention
btop="$terminal --app-id special-btop -e btop"
nvim="$terminal --app-id special-nvim --working-directory=$HOME/dotfiles/ -e zsh -ic \"tmux new-session -s Editor 'nvim'\""

case "$1" in
"term")
  search="special-term"
  tag="$terminal_tag"
  cmd="$term"
  ;;
"lf")
  search="special-lf"
  tag="$lf_tag"
  cmd="$lf"
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
