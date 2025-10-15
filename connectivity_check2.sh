#!/bin/bash

read -p "Which site you want to check?" site
ping -c 4 $site > connectivity.log

# $? --> its check previous status where correctly executed or not / 0 yes and 1 no=error
if [[ $? -eq 0 ]]; 
then
  echo "Successfully connect to $site"
else
  echo "Unable to connect to $site"
fi
echo "Thank you...."

#usefull commands
#basename - strip directory info and only give filename --> text.txt
#dirname - strip the filename and gives directory path , as like pwd
#realpath - gives a full path of a file

