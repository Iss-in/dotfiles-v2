source .cache/wal/colors.sh 
COVER=~/.config/neofetch/fish.png
cp $COVER $COVER.bak
sleep 1
# convert  $COVER -size 125x125 $COVER
convert "$COVER" -resize 100x -background "$background" -extent 500x250 "$COVER"
printf "\e]20;${COVER};100x100+140+20:op=keep-aspect\a"
mv $COVER.bak $COVER 