#!/usr/bin/env bash

cd ~/.config/waybar
read -p "which backup do you want to load: " num
mv "config.jsonc" "tmp" 
mv "config.jsonc.bak${num}" "config.jsonc" 
mv "tmp" "config.jsonc.bak${num}"

mv "style.css" "tmp" 
mv "style.css.bak${num}" "style.css" 
mv "tmp" "style.css.bak${num}"
