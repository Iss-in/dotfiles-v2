source "${HOME}/.cache/wal/colors.sh"
ln -sf    "${HOME}/.cache/wal/rofi.rasi"    "${HOME}/.config/rofi/themes/line.rasi"

file="${HOME}/.cache/wal/rofi.rasi"
sed -i '21s/.*/  background-color : '"$background"';/' $file
sed -i '20s/.*/  text-color : '"$foreground"';/' $file

