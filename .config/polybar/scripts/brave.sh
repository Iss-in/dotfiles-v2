id=$( wmctrl -lx | grep Brave-browser| awk '{ print $1 }' )
old_id=$(xdotool getwindowfocus)
#wmctrl -iR $id 
#xdotool windowminimize $id  || wmctrl -iR $id 
pname=$(cat /proc/$(xdotool getwindowpid $(xdotool getwindowfocus))/comm)
./
if [[ $pname == "brave"  ]]
then
    #echo "active"
   #echo $pname
    xdotool windowminimize $id
    xdotool windowactivate $(cat ~/.config/polybar/scripts/id.txt)
    #xdotool keydown alt key Tab; sleep .1; xdotool keyup alt
else
    #echo "hidden"
    #echo $pname
    xdotool getwindowfocus > ~/.config/polybar/scripts/id.txt
    xdotool windowactivate $id 
fi
#xdotool windowminimize $id  || xdotool windowactivate $id 
