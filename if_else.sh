#!/bin/bash
#if [$marks -gt 40]
#then 
#	echo "True"
#else 
#	echo "False"
#fi


read -p "Enter the marks : " marks

if [[ $marks -lt 30 ]]; then
    echo "Fail"
else
    echo "Pass"
fi
