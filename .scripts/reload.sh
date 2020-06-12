# xdotool mousemove 900 0
sleep 1
# kill -9  `ps -aux | grep hide  | grep -v grep | awk '{ print $2 }'`
# kill -9  `ps -aux | grep polybar  | grep -v grep | awk '{ print $2 }'`
# kill -9  `ps -aux | grep reload  | grep -v grep | awk '{ print $2 }'`

sleep 1
bash ~/.config/polybar/polybar_launch.sh   &
# xdotool mousemove 900 500
# bash ~/.scripts/autohide.sh &
