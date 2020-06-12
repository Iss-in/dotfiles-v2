#!/bin/zsh
killall -q polybar  
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar -c ~/.config/polybar/bspwm-6.ini main &
#polybar -c ~/.config/polybar/bspwm-6.ini openbox &

# polybar -c ~/.config/polybar/bspwm-6.ini user & 
# polybar -c ~/.config/polybar/bspwm-6.ini time & 
# polybar -c ~/.config/polybar/bspwm-6.ini xwindow & 
# polybar -c ~/.config/polybar/bspwm-6.ini bspwm & 

# # polybar -c ~/.config/polybar/bspwm-6.ini tray & 
# polybar -c ~/.config/polybar/bspwm-6.ini right & 
# # polybar -c ~/.config/polybar/bspwm-6.ini bspwm & 

# sleep 2
# xdo lower -a "polybar-tray_eDP1"
