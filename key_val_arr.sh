#!/bin/bash

#How to store the key values pairs


declare -A arr

arr=( [name]=Jhapendra [age]=28 [city]=Paris )

echo "My name is ${arr[name]}"
echo "My name is ${arr[city]}"
