#!/bin/bash
command=$1
dir=$2
cd $dir
pwd
running=true
for file in wallhaven*.png wallhaven*.jpg; do
    if [[ $running == "true" ]];then
        $command  $file 
        echo $(echo $file  |  sed 's/^.*\///')
        sleep 1
    fi
    if read -sn 1 -t 0.25; then
        if [[ "$running" == "true" ]]; then
            running=false
        else 
            running=true
        fi
    fi
done
