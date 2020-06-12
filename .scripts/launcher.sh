# hideIt.sh --name '^Sxiv$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^ToDo$' --wait --direction top --steps 5  --peek 5    --signal &
# hideIt.sh --name '^URxvt$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^drop-down-terminal$' --wait --direction top --steps 5  --peek 5    --signal &
# hideIt.sh --name '^polybar-workspaces1_eDP1$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^polybar-workspaces2_eDP1$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^polybar-music_eDP1$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^polybar-music_bar_eDP1$' --wait --direction top --steps 3  --peek 5    --signal &
# hideIt.sh --name '^polybar-workspaces1_eDP1$' --wait --direction top --steps 5  --peek 5    --signal &
# sleep 2
while true; do
    sleep .5
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
        ~/.scripts/toogle.sh
    fi
done

