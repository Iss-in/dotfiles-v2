ode#!/bin/sh
selected=$(echo "Shutdown
Reboot
Log Outt
Lock
Suspend" | rofi -dmenu prompt =  'power' -location 3   -theme ~/.config/rofi/themes/bspwm-2.rasi -yoffset 47 -width 8 -xoffset -13 -lines 6)

if [ "$selected" == "Shutdown" ]
        systemctl poweroff

elif [ "$selected" == "Reboot" ]
        reboot

elif [ "$selected" == "Log Out" ]
        # then prompt 'Do you really want to exit i3?' 'i3-msg exit'
        loginctl terminate-session $(loginctl session-status | head -n 1 | awk '{print $1}')

elif [ "$selected" == "Lock" ]
        then betterlockscreen -l dim

elif [ "$selected" == "Suspend" ]
        then prompt 'Do you really want to suspend the computer' 'systemctl suspend'

else
        echo "nothing"
fi