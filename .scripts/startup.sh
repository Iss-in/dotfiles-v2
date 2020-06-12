killall -9 xcape
#killall -9 xpad
#killall -9 redshift-gtk
#while pgrep -u $UID -x redshift-gtk >/dev/null; do sleep 3; done
#echo "1"
#while pgrep -u $UID -x xpad >/dev/null; do sleep 1; done
#echo "2"
#while pgrep -u $UID -x xcape >/dev/null; do sleep 1; done
#echo "3"
#echo "no"
#sleep 5
#xpad &
#xpad -t
xcape -e 'Super_L=Alt_L|F1'
mpd &
# redshift-gtk -l 26.46:80.34 -t 5700:3600 -g 0.8 -m randr -v &
