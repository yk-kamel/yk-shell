#!/bin/bash

#get status
STATUS=$(gsettings get org.gnome.desktop.interface color-scheme)

#chnage gsettings (gtk, qt, ncmpcpp (find out how to reload colors without closing), something else)
if [[ $STATUS == "'prefer-light'" ]]; then
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	cp ~/yk-shell/Themes/Coffee-Bean/Config/Hyprland/dark-theme.conf ~/.config/hypr/theme.conf
	cp ~/yk-shell/Themes/Coffee-Bean/Config/ncmpcpp/config-dark  ~/.config/ncmpcpp/config
	pkill ncmpcpp
	N="Switched To Dark Mode"

fi
if [[ $STATUS == "'prefer-dark'" ]]; then
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	cp ~/yk-shell/Themes/Coffee-Bean/Config/Hyprland/light-theme.conf ~/.config/hypr/theme.conf
	cp ~/yk-shell/Themes/Coffee-Bean/Config/ncmpcpp/config-light  ~/.config/ncmpcpp/config
	pkill ncmpcpp
	N="Switched To Light Mode"
fi

hyprctl notify 1 2000 "rgb(d0ba97)" "$N"



