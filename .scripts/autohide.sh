wal -R &
mpd &
mpc pause
while true; do
    sleep 1
    pos="$(xdotool getmouselocation --shell)"
    a=(${pos[0]})
    x=${a[0]}
    x=${x:2}
    y=${a[1]}
    y=${y:2}
    echo $y
    if [[ $y -lt 3 ]]
    then
        # echo $y "out of bound"
        # break
        ~/.scripts/toogle.sh 2
    fi
done


killall -q urxvt   
urxvt &
while [ -z $(pidof urxvt) ] ; do sleep 2; done
sleep 4 
id="$(xdotool search --onlyvisible --name urxvt)"
xdotool windowmove $id 1238 70 
xdotool windowsize $id 670 60 
hideIt.sh --name '^cava' --wait --direction top --steps 5  --peek 5    --signal &
hideIt.sh --name '^Sxiv$' --wait --direction top --steps 5  --peek 5    --signal &

kunst