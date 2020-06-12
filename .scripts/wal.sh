image=$1
mode=$2
if [[ $mode == "light" ]]
then
    echo "light"
    wal -l -i $image
else
    wal -i $image
fi
# oomoxify-cli -s /opt/spotify/Apps -g ~/.cache/wal/colors-oomox 
source "${HOME}/.cache/wal/colors.sh"

ln -sf    "${HOME}/.cache/wal/dunstrc"    "${HOME}/.config/dunst/dunstrc"
ln -sf    "${HOME}/.cache/wal/cavaconfig"    "${HOME}/.config/cava/config"
# ln -sf    "${HOME}/.cache/wal/cavaconfig"    "${HOME}/.config/cava/config"

# Restart dunst with the new color scheme
ln -sf    "${HOME}/.cache/wal/rofi.rasi"    "${HOME}/.config/rofi/themes/line.rasi"
rm ~/.cache/wal/colors-rofi-dark.rasi
cp ~/.cache/wal/colors-rofi-dark2.rasi ~/.cache/wal/colors-rofi-dark.rasi
file="/home/kushy/.cache/wal/colors-rofi-dark.rasi"
sed -i s/@background/$background/g $file
sed -i s/@foreground/$foreground/g $file 

pkill dunst  
dunst &

# #reload Conky
# rm ~/newfile.txt
# colors="$(grep color ~/.cache/wal/colors.sh|sed "s/$/,/g" | head -n 10)"
# echo $colors
# head -n 84 ~/.config/conky/wal.conkyrc > ~/newfile.txt
# echo $colors >> ~/newfile.txt
# #echo "text to insert" >> newfile.txt
# tail -n +86 ~/.config/conky/wal.conkyrc >> ~/newfile.txt
# mv ~/newfile.txt ~/.config/conky/wal.conkyrc
# sleep 1;
# bash killall -SIGUSR1 conky &>/dev/null

# # bash ~/.scripts/reload.sh &>/dev/null

