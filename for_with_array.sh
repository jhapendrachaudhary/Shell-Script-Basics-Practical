#!/bin/bash

arr=(1 2 3 4 heeel hk hello)

for (( i=0; i<${#arr[*]}; i++ ))
do 
  echo "${arr[$i]}";
done
