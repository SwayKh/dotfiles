#!/bin/bash

terminal_tag=$((1 << 11))
lf_tag=$((1 << 12))
dots_tag=$((1 << 13))
monitor_tag=$((1 << 14))

term="$terminal --app-id Special_term -e tmux new-session -s Terminal"
lf="$terminal --app-id Special_lf -e zsh -ic \"tmux new-session -s FileManager 'lf'\"" #lfMention
btop="$terminal --app-id Special_btop -e btop"
nvim="$terminal --app-id Special_nvim --working-directory=$HOME/dotfiles/ -e tmux new-session -s Editor 'nvim'"

# Check if the application is already running
# if [ "$1" = "dots" ]; then
#   # Toggle the scratchpad tag
#   riverctl focus-output next
#   riverctl set-focused-tags 11
# else
#   # Launch the application and send it to the scratchpad tag
#   riverctl spawn "$term -e nvim"
#   sleep 0.5 # Wait for the application to launch
#   riverctl set-focused-tags 11
#   riverctl focus-output next
# fi
