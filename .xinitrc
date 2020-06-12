#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


xmodmap ~/.xmodmap
~/.fehbg
#export GTK_CSD=0
#export LD_PRELOAD="/home/kushy/.mods/gtk3-nocsd/libgtk3-nocsd.so.0:${LD_PRELOAD}"
#exec openbox-session
exec bspwm
