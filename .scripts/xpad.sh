kill -9  `ps -aux | grep hideIt.sh | grep Mods | grep -v grep | awk '{ print $2 }'`  
kill -9  `ps -aux | grep hideIt.sh | grep Endsem | grep -v grep | awk '{ print $2 }'` 
kill -9  `ps -aux | grep hideIt.sh | grep ToDo | grep -v grep | awk '{ print $2 }'`  

# killall xpad
# wait 3;
hideIt.sh --name '^Endsem$' --wait --direction top --signal &
hideIt.sh --name '^Mods$' --wait --direction bottom  --signal &
hideIt.sh --name '^ToDo$' --wait --direction right --signal &