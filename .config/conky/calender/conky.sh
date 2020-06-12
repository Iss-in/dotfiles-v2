#/bin/zsh
# result=$(ps -aux | grep "" | grep -v grep)


auto_close () {
  IFS=' ' read x y <<< $(xdotool getmouselocation | awk '{print $1 $2}' | sed 's/x://;s/y:/ /')
  x1=651
  x2=1227
  y1=9
  y2=274
  if [ $x -lt $x1 ] ||[ $x -gt $x2 ] || [ $y -lt $y1 ] ||[ $y -gt $y2 ]
  then
      echo "outta bounds baby"
      kill -9 $(ps -aux | grep  'calendar.conkyrc' | grep -v grep  | awk '{print $2}')
      kill -9 $(ps -aux | grep  'cnee' | grep -v grep  | awk '{print $2}')
      #xdotool keydown control keydown shift key space keyup shift keyup control
  fi
}

get_click_location () {
  echo "yeah"
  process="calendar.conkyrc"
  key="shift"
  if ps -aux | grep $process | grep -v grep; then
    kill -9 $(ps -aux | grep  $process | grep -v grep  | awk '{print $2}')
    kill -9 $(ps -aux | grep  'cnee' | grep -v grep  | awk '{print $2}')
  else
    conky -c /home/kushy/.config/conky/calendar.conkyrc
    #xdotool keydown control key grave keyup control
    cnee --record --mouse | awk  '/7,4,0,0,1/ { system("/home/kushy/.config/conky/conky.sh 2") }'
  fi
  echo "done"
}

if [ $1 -eq 1 ]
then
  get_click_location
elif [ $1 -eq 2 ]
then
  auto_close
fi
