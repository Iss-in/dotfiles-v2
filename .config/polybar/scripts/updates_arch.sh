#!/bin/sh
set -m

STRING_TEMPLATE=' %s, %s\n'
TMP_DIR=/tmp/updates_arch

! [ -d "$TMP_DIR" ] && mkdir "$TMP_DIR"
echo "?" > "$TMP_DIR/pacman"
echo "?" > "$TMP_DIR/aur"

_printupdates() {
    printf "$STRING_TEMPLATE" $(cat "$TMP_DIR/pacman") $(cat "$TMP_DIR/aur")
}

_checkpacman() {
    _pacman_updates=$(checkupdates 2> /dev/null | wc -l)
    [ $? -eq 0 ] && echo "$_pacman_updates" > "$TMP_DIR/pacman"
}

_checkaur() {
    _aur_updates=$(yay -Qum 2> /dev/null | wc -l)
    [ $? -eq 0 ] && echo "$_aur_updates" > "$TMP_DIR/aur"
}

_checkupdates() {
    _checkpacman && _printupdates
    _checkaur && _printupdates
}

# watch for pacman file activity
while inotifywait -e close_write,moved_to,create -q \
    --exclude '.*\.part' /var/lib/pacman/sync > /dev/null
do
    while pgrep pacman 2>&1 > /dev/null; do sleep 1; done
    _checkpacman && _printupdates
done &
pacman_process=$!

# watch for aur file activity
while inotifywait -e close_write,moved_to,create -q \
    "$XDG_CACHE_HOME/yay" > /dev/null
do
    while pgrep yay 2>&1 > /dev/null; do sleep 1; done
    _checkaur && _printupdates
done &
aur_process=$!

# kill inotifywait processes on exit
trap "kill -- -$pacman_process; kill -- -$aur_process" EXIT

# initial update
_printupdates
_checkupdates

_usr1_handler() {
    kill -- -$sleep_pid
    _checkupdates
}

# update on USR1 signal
trap _usr1_handler USR1

#echo "my pid is $$"

while true
do
    # update every 15min
    sleep 900 && _checkupdates &
    sleep_pid=$!
    wait $sleep_pid
done

