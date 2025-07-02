#!/bin/bash
export DISPLAY=:0
export WAYLAND_DISPLAY=wayland-1  # or wayland-0 depending on your setup

cd ~/wallpapers
read -p "Enter the name of the wallpaper you wish to load (the name in ~/wallpapers): " filepath
echo "preload = /home/bobywoby/wallpapers/${filepath}
wallpaper = ,/home/bobywoby/wallpapers/${filepath}
" > ~/.config/hypr/hyprpaper.conf

hyprctl hyprpaper reload  ,~/wallpapers/${filepath} > ~/wallpapers/scripts/res.txt
exec wal -i ~/wallpapers/${filepath}
sleep(100)
exec pywalfox update
