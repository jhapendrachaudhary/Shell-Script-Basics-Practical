#!bin/bash

arr=()
while true 
do
  read -p "Enter the element :- " input

  if [[ $input == "exit" ]]; then
    echo "Existing program..."
    break
  fi

   arr+=("$input")
 done

for (( i=0; i<${#arr[@]}; i++ ))
do
  echo "Array : - ${arr[$i]}"
done

