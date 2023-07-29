#!/bin/bash

grim -g "$(slurp -o)" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')
