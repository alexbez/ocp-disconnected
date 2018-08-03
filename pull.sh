#!/bin/sh
# pull.sh <image_list_file>

while read -r img
do
  echo "Pulling '$img'"
  docker pull $img
done < "$1"
echo "Done"
