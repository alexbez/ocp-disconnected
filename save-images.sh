#!/bin/sh
# save-images.sh <image_list_file>

cmd="docker save -o $1.tar "
while read -r img
do
  cmd="$cmd $img"
done < "$1"
echo $cmd
eval "$cmd"
