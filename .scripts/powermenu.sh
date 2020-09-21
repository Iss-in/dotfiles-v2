#!/bin/bash
killall -9 dunst
rofi_command="rofi -theme ~/.config/rofi/themes/powermenu.rasi"
n30f ~/.config/rofi/images/powermenu_dark.png -x 1828 -y 330 &
### Options ###
power_off="Shutdown"
reboot="Reboot"
hibernate="Hibernate"
#suspend="鈴  Suspend"
log_out="Logout"
# Variable passed to rofi
options="$power_off\n$reboot\n$hibernate\n$log_out"

chosen="$(echo -en "Shutdown\0icon\x1fsystem-shutdown\nLogout\0icon\x1fsystem-log-out\nHibernate\0icon\x1fsystem-hibernate\nReboot\0icon\x1fsystem-reboot" | rofi -theme ~/.config/rofi/themes/powermenu.rasi -dmenu  -show-icons -selected-row 2)"
#pure-text
#chosen="$(echo -en "Shutdown\nLogout\nHibernate\nReboot" | rofi -theme ~/.config/rofi/themes/powermenu.rasi -dmenu  -show-icons -selected-row 2)"

case $chosen in
    $power_off)
    	 systemctl poweroff
        ;;
    $reboot)
         systemctl reboot
        ;;
    $hibernate)
        systemctl hibernate
        ;;
   # $suspend)
        #~/bin/standalone/blurlock.sh && systemctl suspendecho -e "Option #1\nOption #2\nOption #3" | rofi -dmenu

       # ;;
    $log_out)
        bspc quit
        ;;
esac
killall -9 n30f
