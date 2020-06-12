#!/bin/env zsh
#IFS=- read var1 var2 <<< "$(cat quote.txt)"
# lines =  cat "/home/kushagra/.lyrics/$(mpc | head -1).txt" | wc -l 
mpc | awk '/%/ {print $3}' | head -1 > /tmp/tmp.txt
IFS=/ read current end <<< "$(cat /tmp/tmp.txt)"
# mpc | awk '/%/ {print $3}' | head -1 |IFS=/ read current end 
case "$1" in

"title")  mpc -f %title% | head -1 ;;
"current")  echo -n $current;;
"end")  echo -n $end;;   
"artist")  mpc -f %artist% | head -1;;
"progress") mpc | awk '/%)/ {print $4}' | sed "s|(||;s|)||;s|%||" ;;
"lines")  cat "/home/kushagra/.lyrics/$(mpc | head -1).txt" | wc -l ;;
"lyrics")   mpc | awk '/%/ {print $3}' | head -1 |IFS=/ read current end 
                lines="$(cat "/home/kushagra/.lyrics/$(mpc | head -1).txt" | wc -l )" 
                echo $end | IFS=: read minutes seconds
                time_in_seconds="$(( $minutes * 60 + $seconds ))"
                interval="$(( $time_in_seconds / 15 ))"
                file="/home/kushagra/.lyrics/$(mpc | head -1).txt"
                count=15
                echo "#######lyrics#########"
                sleep 15
                while [[ $count -lt 900 ]];
                do
                    echo "#######lyrics#########"
                    cat $file | head -$((  $count )) | tail -15 > /tmp/lyrics
                    count=$[$count+1]
                    sleep 4
                done
esac
