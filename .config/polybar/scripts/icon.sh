#!/bin/bash
name=$(cat "/proc/$(xdotool getwindowpid "$(xdotool getwindowfocus)" 2>/dev/null )/comm" 2>/dev/null)
if [[ -z $name  ]]
then
    echo "%{F#ffa} %{F-}"
fi
icon=$(cat ~/.scripts/fa-sheet | grep $name | head -1 | awk '{print $1}')
#icon=" "$icon" "
echo $icon
# echo $name