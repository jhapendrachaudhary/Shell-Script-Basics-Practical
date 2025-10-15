#!/bin/bash

#myVar="Hello World!"

#length=${#myVar}

#upper=${x^^}

#lower=${y,,}

#replace=${myVar/World/Buddy}

#slice=${myVar:6:11}


myVar="Hey Buddy, How are you?, Buddy"

echo "${myVar}"
myVarLength=${#myVar}
echo "Length of the myVar is $myVarLength"

echo "Upper case is ${myVar^^}"
echo "Lower case is ${myVar,,}"
echo "New Var is ---------- ${myVar/Buddy/Bro}"
echo "Slicing var is -------${myVar:11}"
