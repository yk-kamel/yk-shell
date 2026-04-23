#!/bin/bash

RAND=$(find ~/Documents/Rice/Current/Wallpaper/Light/ -name '*.jpg' -type f | shuf -n 1)

hyprctl hyprpaper wallpaper ", $RAND"