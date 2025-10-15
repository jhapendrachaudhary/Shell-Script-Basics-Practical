#!/bin/bash
#item="home/paul/file.txt"
#for item in $(cat $items)
#do
#	echo $item
#done

items="/home/unknown/Documents/main_script"

for item in $(cat $items)
do
  echo "$item"
done
