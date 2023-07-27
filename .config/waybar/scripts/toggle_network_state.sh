#!/bin/sh

state=$(nmcli radio wifi)

if [[ $state == 'disabled' ]]; then
	nmcli radio wifi on
else
	nmcli radio wifi off
fi
