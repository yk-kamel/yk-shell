#!/bin/bash

RAND=$(find ~/yk-shell/Themes/Coffee-Bean/Wallpaper/Dark/ -name '*.jpg' -type f | shuf -n 1)

hyprctl hyprpaper wallpaper ", $RAND"
