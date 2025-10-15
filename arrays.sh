#How to define an array?
#
#myArray=(1 2 Hello "Hey man")
#
#
#How to get values from an array?
#
#echo "${myArray[0]"
#echo "${myArray[1]"

arr=(1 2 33.33 hello "pops, do you need helps?")

echo "${arr[3]}"
echo "${arr[2]}"
echo "Printing all values : ${arr[*]}"

echo "Values from index 2-3 ${arr[*]:2:2}"

#Updating our array with new values
arr+=(New 30 40)

echo "Values of new array are ${arr[*]}"
