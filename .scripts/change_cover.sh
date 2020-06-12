#!/usr/bin/zsh
# rm -rf /tmp/kunst.jpg
# script_name=${BASH_SOURCE[0]}
# for pid in $(pidof -x $script_name); do
#     if [ $pid != $$ ]; then
#         : $(kill -9 $pid)
#     fi 
# done

# kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$)
zmodload zsh/mathfunc
title="$(~/.scripts/music.sh title)"
image="/home/kushagra/.mpd/albumart/$title.png"
if [ ! -f "$image" ]; then
    echo "$title does not exist"
    ~/.scripts/fetch_albumart
    convert  /tmp/kunst.jpg  -rotate "330" -gravity Center \( -size 250x250 xc:Black -fill White -draw 'circle 125 125 125 1' -alpha Copy \) -compose CopyOpacity -composite -trim "$image"
    # mv /tmp/kunst.jpg "/home/kushagra/.mpd/albumart/$title.jpg"
fi


# convert  "$image"  -rotate "330" -gravity Center \( -size 250x250 xc:Black -fill White -draw 'circle 125 125 125 1' -alpha Copy \) -compose CopyOpacity -composite -trim /tmp/circle.png
ln -sf "$image" /tmp/circle.png
dunstify "Now Playing" "$(mpc current)" -p > /tmp/music.pid -r "$(cat /tmp/music.pid)" --icon /tmp/circle.png

angle=330
current_angle=330
# rm  /tmp/[0-9].png
while [[ $1 == "rotate" ]];
do
    if [ $angle -lt 690 ]
    then
        convert  "$image"  -rotate "$angle" -gravity Center \( -size 250x250 xc:Black -fill White -draw 'circle 125 125 125 1' -alpha Copy \) -compose CopyOpacity -composite -trim /tmp/$angle.png
        angle=$[$angle+1]
        convert  "$image"  -rotate "$angle" -gravity Center \( -size 250x250 xc:Black -fill White -draw 'circle 125 125 125 1' -alpha Copy \) -compose CopyOpacity -composite -trim /tmp/$angle.png
        angle=$[$angle+1]
    fi
    sleep 0.2
    cp /tmp/$current_angle.png /tmp/circle.png
    current_angle=$[$current_angle+1]

    if [ $current_angle -gt 690  ]
    then
        current_angle=0
    fi
    sleep 0.2
done


IFS=' ' read r g b a <<< $(convert $image -scale 1x1\! -format '%[pixel:u]' info:- | sed 's/.*(//;s/)//;s/%,/ /g')
r=$((r/100.0)) 
g=$((g/100.0)) 
b=$((b/100.0)) 
echo "$r $g $b --colors"
sed -i "s/ring_bg_red = .*/ring_bg_red = $r/"  '/home/kushagra/.config/conky/script.lua'
sed -i "s/ring_bg_green = .*/ring_bg_green = $g/" '/home/kushagra/.config/conky/script.lua'
sed -i "s/ring_bg_blue = .*/ring_bg_blue = $b/" '/home/kushagra/.config/conky/script.lua'

# r=$((r*255)) 
r=$((int(rint(r*255))))
g=$((int(rint(g*255))))
b=$((int(rint(b*255))))

# echo "$r $g $b --colors"
hex=$(color-converter $r $g $b | sed 's/.*#//')
# echo $hex
sed -i "s/#define COLOR (#.* \*/#define COLOR (#$hex \*/ " /home/kushagra/.config/glava/bars.glsl
killall -9 glava > /dev/null 2>&1
glava > /dev/null 2>&1 &
sleep 2 && xdo lower -N Conky
