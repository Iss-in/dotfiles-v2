rm ~/newfile.txt
colors="$(grep color ~/.cache/wal/colors.sh|sed "s/$/,/g" | head -n 10)"
echo $colors
head -n 84 ~/.config/conky/wal.conkyrc > ~/newfile.txt
echo $colors >> ~/newfile.txt
#echo "text to insert" >> newfile.txt
tail -n +87 ~/.config/conky/wal.conkyrc >> ~/newfile.txt
mv ~/newfile.txt ~/.config/conky/wal.conkyrc

