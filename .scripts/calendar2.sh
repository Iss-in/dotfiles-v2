#!/bin/zsh
# var=$(gcalcli --lineart=ascii  --nocolor --refresh agenda '0am' | sed -r '/^\s*$/d')
var=$(cat /tmp/calendar.txt)
source /home/kushagra/.cache/wal/colors.sh
lines=$(( $(echo $var | wc -l) + 1 ))
back_h=$(( 65 * lines + 10 ))
echo "\n\${image /home/kushagra/back.png  -p -1,-1 -s 260x$back_h}\n\${voffset -48}"

font1="\${font RoundedMplus1c Nerd Font:bold:size=5}"
font2="\${font RoundedMplus1c Nerd Font:medium:size=8}"
font3="\${font RoundedMplus1c Nerd Font:bold:size=10}"
pos_y=50
while IFS='\n' read -r line
do
#   echo "$line"
#   echo $line | sed 's/:.\{4\}//'
    if [[ $line != "" ]] then
        # line=$(echo $line | xargs )
        # echo $line 
        IFS=' ' read timer task <<< $line
        task=$(echo $task | xargs )
        # echo "\${color $color1}\${offset -0}\${voffset 10}  \${color #fff}$task\${goto 300}\$alignr\${offset 0}\${voffset 0}$timer"
        # echo -n "\n\${image /home/kushagra/.config/conky/back.png  -p -2,$pos_y -s 245x45}${font1}\${offset -5}\${color $color1}\${color $color3}\${offset 10}\${voffset -2}$font2$timer\${goto 31}\${voffset 15}\${color $color7}$font3$task\${voffset 17}"
        echo -n "\n\${image /home/kushagra/.config/conky/back2.png  -p -6,$pos_y -s 265x68}${font1}\${offset -5}\${color $color1}\${color $color3}\${offset 10}\${voffset -2}$font2$timer\${goto 22}\${voffset 15}\${color $color7}$font3$task\${voffset 17}"
        pos_y=$(( pos_y + 57 ))

    fi
done <<< "$var"
