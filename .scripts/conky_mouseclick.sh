#!/bin/bash
# echo "yeah baby"
IFS=' ' read x y <<< $(xdotool getmouselocation | awk '{print $1 $2}' | sed 's/x://;s/y:/ /')
x1=1314
x2=1907
y1=51
y2=336
if [ $x -lt $x1 ] ||[ $x -gt $x2 ] || [ $y -lt $y1 ] ||[ $y -gt $y2 ]
then
    echo "outta bounds baby"
    kill -9 $(ps -aux | grep  'calendar.conkyrc' | grep -v grep  | awk '{print $2}')
    kill -9 $(ps -aux | grep  'cnee' | grep -v grep  | awk '{print $2}')
    xdotool keydown control keydown shift key space keyup shift keyup control
fi