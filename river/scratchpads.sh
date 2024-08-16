#!/bin/bash
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

term="$terminal --app-id Special_term -e zsh -ic \"tmux new-session -s Terminal\""
lf="$terminal --app-id Special_lf -e zsh -ic \"tmux new-session -s FileManager 'lf'\"" #lfMention
btop="$terminal --app-id Special_btop -e btop"
nvim="$terminal --app-id Special_nvim --working-directory=$HOME/dotfiles/ -e zsh -ic \"tmux new-session -s Editor 'nvim'\""

case "$1" in
"term")
  search="Special_term"
  tag="$terminal_tag"
  cmd="$term"
  ;;
"lf")
  search="Special_lf"
  tag="$lf_tag"
  cmd="$lf"
  ;;
"btop")
  search="Special_btop"
  tag="$monitor_tag"
  cmd="$btop"
  ;;
"nvim")
  search="Special_nvim"
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
