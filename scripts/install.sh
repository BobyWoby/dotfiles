#!/usr/bin/env bash

sudo pacman -S --needed base-devel
# git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

sudo pacman -S cava wezterm fastfetch hyprlock hyprshot hyprpaper python python-pipx neovim rofi-wayland waybar --needed --noconfirm

pipx install pywal16

