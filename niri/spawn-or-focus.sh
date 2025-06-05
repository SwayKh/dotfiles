#! /usr/bin/env bash

# Port of my River scratchpad script for Niri

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Error: No argument provided."
  exit 1
fi

terminal="footclient"

term="$terminal --app-id special-term -e zsh -ic 'tmux new-session -s Terminal'"
btop="$terminal --app-id special-btop -e zsh -ic btop"
nvim="$terminal --app-id special-nvim --working-directory=$HOME/dotfiles/ -e zsh -ic 'tmux new-session -s Editor nvim'"
files="$terminal --app-id special-files -e zsh -ic yazi"
projectTerm="$terminal --app-id special-project -e zsh -ic '$HOME/scripts/project.tmux'"

case "$1" in
"special-term")
  cmd="$term"
  ;;
"special-files")
  cmd="$files"
  ;;
"special-btop")
  cmd="$btop"
  ;;
"special-nvim")
  cmd="$nvim"
  ;;
"special-project")
  cmd="$projectTerm"
  ;;
*)
  echo "Unhandled case provided. Exiting"
  exit 1
  ;;
esac

# Get window info from niri msg windows output
WIN_INFO=$(niri msg -j windows | jq --arg search "$1" '.[] | select (.app_id | test($search)) | { id, is_focused }')

ID=$(echo "$WIN_INFO" | jq -r '.id // empty')
IS_FOCUSED=$(echo "$WIN_INFO" | jq -r '.is_focused // empty')

# Spawn window if it's not open, or focus the window if it's already open
if [ -z "$ID" ]; then
  niri msg action spawn -- "sh" "-c" "$cmd"
elif [ "$IS_FOCUSED" = "true" ]; then
  niri msg action focus-workspace-previous
else
  niri msg action focus-window --id "$ID"
fi
