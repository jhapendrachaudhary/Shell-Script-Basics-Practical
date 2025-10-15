#!/bin/bash

a=1

until [[ $a -eq 100 ]]
do 
  echo -n "$a  "
  let a++
done
echo
