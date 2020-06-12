#!/bin/zsh
# n=6
# check () {
#     python3 /home/kushagra/.mods/google-reminders-cli/remind.py -l $n | grep $(date +'%m-%d') | sed 's/;.*$//; s/^.\{11\}//;s/: / /'  > /tmp/reminders.txt
#     while [ $? -eq 0 ]
#     do
#         echo $n
#         echo $(check $(( n - 1 )))
#     done
# }
# check 6
# python3 /home/kushagra/.mods/google-reminders-cli/remind.py -l 4 | grep $(date +'%m-%d') | sed 's/;.*$//; s/^.\{11\}//;s/: / /'  > /tmp/reminders.txt
python3 /home/kushagra/.mods/google-reminders-cli/remind.py -l 1 | grep '05-29' | sed 's/;.*$//; s/^.\{11\}//;s/: / /'  > /tmp/reminders.txt

var=$(cat /tmp/reminders.txt)
source /home/kushagra/.cache/wal/colors.sh
lines=$(echo $var | wc -l)
back_h=$(( 65 * lines + 60 ))
echo "\n\${image /home/kushagra/back.png  -p 40,10 -s 0x0}\n\${voffset 35}"

font1="\${font RoundedMplus1c Nerd Font:bold:size=6}"
font2="\${font RoundedMplus1c Nerd Font:medium:size=8}"
font3="\${font RoundedMplus1c Nerd Font:bold:size=10}"
pos_y=150
while IFS='\n' read -r line
do
#   echo "$var"
#   echo $line | sed 's/:.\{4\}//'
    if [[ $line != "" ]]; then
        # line=$(echo $line | xargs )
        # echo $line 
        IFS=' ' read timer task <<< $line
        task=$(echo $task | xargs )
        # echo "\${color $color1}\${offset -0}\${voffset 10}  \${color #fff}$task\${goto 300}\$alignr\${offset 0}\${voffset 0}$timer"
        # echo -n "\n\${image /home/kushagra/.config/conky/back.png  -p -2,$pos_y -s 245x45}${font1}\${offset -5}\${color $color1}\${color $color3}\${offset 10}\${voffset -2}$font2$timer\${goto 31}\${voffset 15}\${color $color7}$font3$task\${voffset 17}"
        echo -n "\n\${image ~/.config/conky/conky_calendar/strip.png  -p -10,$pos_y -s 310x68}${font1}\${offset 2}\${color $color1}\${color $color3}\${offset 10}\${voffset -2}$font2$timer\${goto 30}\${voffset 15}\${color #fff}$font3$task\${voffset 17}"
        pos_y=$(( pos_y + 57 ))

    fi
done <<< "$var"
