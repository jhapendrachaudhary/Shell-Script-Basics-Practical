#!/bin/bash
#RANDOM - A random integer between 0 and 32767 is generated 
#
#UID - User Id of the user logged in

echo $((RANDOM % 60 +1))

# Random number between Min and Max

#echo $(( MIN + RANDOM %(MAX - MIN + 1) ))
echo $((10 + RANDOM % (100 -10 +1) ))
