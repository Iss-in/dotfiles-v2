
# hideIt.sh --name '^Endsem$' --toggle &
# hideIt.sh --name '^Mods$' --toggle &
# hideIt.sh --name '^ToDo$' --toggle &
#i3-msg 'workspace 11' 
 hideIt.sh --name '^dropdown$' --toggle &
hideIt.sh --name '^dropdown2$' --toggle &

# function toogle(){
#     echo 'hello'
#     hideIt.sh --name '^polybar-music_title_eDP1$' --toggle &
# # sleep .1
#     hideIt.sh --name '^Sxiv$' --toggle &
#     sleep .01
#     hideIt.sh --name '^cava$' --toggle &
#     sleep .01
#     hideIt.sh --name '^ToDo$' --toggle &
#     sleep .01
#     hideIt.sh --name '^polybar-workspaces2_eDP1$' --toggle &
#     sleep .01
#     hideIt.sh --name '^polybar-music_bar_eDP1$' --toggle &
#     sleep .01
#     hideIt.sh --name '^Polybar tray window$' --toggle &
#     sleep .01
#     hideIt.sh --name '^polybar-workspaces1_eDP1$' --toggle &
#     sleep .01
#     hideIt.sh --name '^Mods$' --toggle &
#     sleep .01
#     hideIt.sh --name '^Endsem$' --toggle &
# }

# toogle
# prompt=$1
# if [[ $prompt -eq 2 ]]
# then
#     sleep 1
#     while true; do
#         pos="$(xdotool getmouselocation --shell)"
#         a=(${pos[0]})
#         y=${a[1]}
#         y=${y:2}
#         # echo $y
#         y=$((y+3))
#         sleep .1
#         if [[ $y -gt 120 ]]
#         then
#             echo $y
#             echo "out of range"
#             break
#         fi
#     done
# toogle
# fi


