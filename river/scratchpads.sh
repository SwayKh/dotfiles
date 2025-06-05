#! /usr/bin/env bash
#
# Riverctl script to open scratchpads, and open programs if Scratchpads are
# empty. Usage "./scratchpads.sh <term|btop|lf|nvim|project>"
#

#   █████████                                █████             █████                              █████
#  ███░░░░░███                              ░░███             ░░███                              ░░███
# ░███    ░░░   ██████  ████████   ██████   ███████    ██████  ░███████   ████████   ██████    ███████
# ░░█████████  ███░░███░░███░░███ ░░░░░███ ░░░███░    ███░░███ ░███░░███ ░░███░░███ ░░░░░███  ███░░███
#  ░░░░░░░░███░███ ░░░  ░███ ░░░   ███████   ░███    ░███ ░░░  ░███ ░███  ░███ ░███  ███████ ░███ ░███
#  ███    ░███░███  ███ ░███      ███░░███   ░███ ███░███  ███ ░███ ░███  ░███ ░███ ███░░███ ░███ ░███
# ░░█████████ ░░██████  █████    ░░████████  ░░█████ ░░██████  ████ █████ ░███████ ░░████████░░████████
#  ░░░░░░░░░   ░░░░░░  ░░░░░      ░░░░░░░░    ░░░░░   ░░░░░░  ░░░░ ░░░░░  ░███░░░   ░░░░░░░░  ░░░░░░░░
#                                                                         ░███
#                                                                         █████
#                                                                        ░░░░░

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
project_tag=$((1 << 18))

term="$terminal --app-id special-term -e zsh -ic 'tmux new-session -s Terminal'"
btop="$terminal --app-id special-btop -e zsh -ic btop"
nvim="$terminal --app-id special-nvim --working-directory=$HOME/dotfiles/ -e zsh -ic 'tmux new-session -s Editor nvim'"
files="$terminal --app-id special-files -e zsh -ic yazi"
projectTerm="$terminal --app-id special-project -e zsh -ic '$HOME/scripts/project.tmux'"

case "$1" in
"special-term")
  tag="$terminal_tag"
  cmd="$term"
  ;;
"special-files")
  tag="$files_tag"
  cmd="$files"
  ;;
"special-btop")
  tag="$monitor_tag"
  cmd="$btop"
  ;;
"special-nvim")
  tag="$dots_tag"
  cmd="$nvim"
  ;;
"special-project")
  tag="$project_tag"
  cmd="$projectTerm"
  ;;
*)
  echo "Unhandled case provided. Exiting"
  exit 1
  ;;
esac

if lswt | grep -q "$1"; then
  riverctl set-focused-tags "$tag"
else
  riverctl spawn "$cmd"
  riverctl set-focused-tags "$tag"
fi
