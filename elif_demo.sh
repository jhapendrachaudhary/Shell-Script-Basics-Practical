#!/bin/bash

read -p "Enter the marks" marks

if [[ $marks -ge 40 && $marks -lt 50 ]]; then
  echo "Pass"
elif [[ $marks -ge 80 ]]; then
  echo "First devision"
 elif [[ $marks -ge 50 && $marks -lt 80 ]]; then
   echo "Second devision"
  else
    echo "fail"
fi

