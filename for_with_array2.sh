#!/bin/bash

arr=(1 2 3 4 5 "hello buudy" "This is array" "using for loop")
#legth= ${#arr[@ or *]}
for (( i=0; i<${#arr[@]}; i++ ))
do
  echo "Array elements are : - ${arr[$i]}"
done
