#!/bin/bash

add(){
  (( a= $1 + $2 ))
  echo "Additions is :  $a"
}

sub(){
  result=$(( $1 - $2 ))
  echo "Subraction is : $result"
}

mul(){
  result=$(($1*$2))
  echo "Multiplication is : $result"
}

div(){
  result=$(($1/$2))
  echo "Division is : $result"
}

div 20 4
mul 20 10
add 10 20
sub 200 10

