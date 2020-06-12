image="$(ls ~/.QuickWall | shuf -n 1)"
echo $image
bash ~/.scripts/wal.sh ~/.QuickWall/$image &>/dev/null
