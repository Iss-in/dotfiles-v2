#!/bin/zsh
# var=$(gcalcli --lineart=ascii  --nocolor --refresh agenda '0am' | sed '1d;2s/^.*[0-9]  //')
var=$(cat /tmp/calendar.txt)
source /home/kushagra/.cache/wal/colors.sh
# echo $var
# line1=$(echo $var | head -2 | tail -1)
# var=$(echo $var | sed '2d' )
# echo "\${color $background}$line1"
font1="\${font RoundedMplus1c Nerd Font:bold:size=5}"
font2="\${font RoundedMplus1c Nerd Font:medium:size=8}"
font3="\${font RoundedMplus1c Nerd Font:bold:size=11}"
while IFS='\n' read -r line
do
#    echo "$line"
#   echo $line | sed 's/:.\{4\}//'
    if [[ $line != "" ]] then
        # line=$(echo $line | xargs )
        # echo $line 
        IFS=' ' read timer task <<< $line
        # echo $task
        # echo "\${color $color1}\${offset -0}\${voffset 10}  \${color #fff}$task\${goto 300}\$alignr\${offset 0}\${voffset 0}$timer"
        echo "\n$font1\${offset -5}\${color $color1}\${color $color3}\${offset 10}\${voffset -2}$font2$timer\${goto 31}\${voffset 15}\${color $color7}$font3$task\${voffset -3}"
   fi
done <<< "$var"