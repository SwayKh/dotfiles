#!/bin/bash

# awk explaination: https://stackoverflow.com/questions/13534306/how-can-i-set-the-grep-after-context-to-be-until-the-next-blank-line
# grep explaination: https://stackoverflow.com/questions/1546711/can-grep-show-only-words-that-match-search-pattern
connected=$(bluetoothctl info $1 | grep "Connected" | cut -d ' ' -f2)
device=$(bluetoothctl info | grep -i Device | cut -d' ' -f2- | cut -d' ' -f1)
percent=$(upower --dump | tr '[:lower:]' '[:upper:]' | awk "/$device/" RS= | grep -oE '[0-9]{1,3}%')

if [[ $connected == "yes" ]]; then
  if [ -z "$percent" ]; then
    echo ""
  else
    echo "{\"text\": \"$percent\"}"
  fi
else
	echo ""
fi
