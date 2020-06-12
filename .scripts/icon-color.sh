#!/bin/bash
rm -rf  ~/.icons/baloons
cp -r ~/.icons/backup/archdroid ~/.icons/baloons










source /home/kushy/.cache/wal/colors.sh
icon_theme=/home/kushy/.icons/$(cat /home/kushy/.config/gtk-3.0/settings.ini | grep icon-theme | sed 's/.*=//')
dir="$icon_theme/places/scalable"
files=("folder-music.svg" "folder-pictures.svg" "user-desktop.svg" "folder-documents.svg" "folder-download.svg" "folder-publicshare.svg"  "folder-templates.svg" "folder-arch.svg")
read -p "$(echo -e 'choose your folders: \n 1. mono-colour \n 2. multi-colour \n 3. restore \nEnter your choice: ')" choice
case $choice in
1)  
    color="$color2"
    for file in ${files[@]}; do 
        sed -i "s/fill=\"#.\{6\}\"/fill=\"$color\"/" $dir/$file
    done;;

2)  
    num=1
    for file in ${files[@]}; do 
    # color=$(eval "echo \$color$((1 + RANDOM % 15))" )  ###for random colors
        color=$(eval "echo \$color$num" )
        sed -i "s/fill=\"#.\{6\}\"/fill=\"$color\"/" $dir/$file
        num=$((num+1))
    done
    ln -sf  $icon_theme/places/32/src/16_yellow.svg    $icon_theme/places/32/user-desktop.svg
    ln -sf  $icon_theme/places/32/src/16_blue.svg    $icon_theme/places/32/folder-documents.svg
    ln -sf  $icon_theme/places/32/src/16_purple.svg    $icon_theme/places/32/folder-download.svg
    ln -sf  $icon_theme/places/32/src/16_green.svg    $icon_theme/places/32/folder-pictures.svg
    ln -sf  $icon_theme/places/32/src/16_red.svg        $icon_theme/places/32/user-home.svg
    ln -sf  $icon_theme/places/32/src/16_white.svg        $icon_theme/places/32/user-trash.svg
    ;;

3)
    cp -r  /home/kushy/.icons/oomox-baloon.bak /home/kushy/.icons/oomox-baloon ;;

esac
ln -sf ~/.icons/custom/blank.svg $icon_theme/actions/scalable/go-next-symbolic.svg
ln -sf ~/.icons/custom/blank.svg $icon_theme/actions/scalable/go-previous-symbolic.svg

gtk-update-icon-cache $icon_theme
killall -9 nautilus
nautilus -w &
