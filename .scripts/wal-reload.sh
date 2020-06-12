#!/bin/bash
# Symlink dunst config

source "${HOME}/.cache/wal/colors.sh"

ln -sf    "${HOME}/.cache/wal/dunstrc"    "${HOME}/.config/dunst/dunstrc"
ln -sf    "${HOME}/.cache/wal/cavaconfig"    "${HOME}/.config/cava/config"

# Restart dunst with the new color scheme
pkill dunst
dunst &
~/.config/polybar/launch-single.sh
~/.scripts/conky.sh
