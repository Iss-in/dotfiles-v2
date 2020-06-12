title=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '"' -f 2)
artist=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | grep "xesam:artist" -A 2 | tail -1 | cut -d '"' -f 2)
echo $artist-$title
 Client ID db11116530874239b4757ede9c792fac 
 Client Secret 3186ecbc9c5e4b919e6ae892db82ac0d
 http://localhost:8888 