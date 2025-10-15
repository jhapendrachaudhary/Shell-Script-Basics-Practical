#!/bin/bash

echo "Provide an options"
echo ""
echo "a --> Print Date"
echo "b --> List of files"
echo "c --> Current Location"

read -p "Enter your choise" choice 

case $choice in
  a)
   echo "This is current date"	
    date
    echo "Done"
    ;;
  b) ls;;
  c) pwd;;
  *) echo "Please enter the valid letter"
esac
echo "Thanks for using my app,"
