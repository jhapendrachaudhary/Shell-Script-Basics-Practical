#!/bin/bash
#VAR_NAME = value
#VAR_NAME = $(hostname)
#
#echo $VAR_NAME

#Script to show how to use variables
NAME="Ram"
AGE=26

echo "My name is $NAME and age is $AGE"

#Var to store the output of a command
HONSTNAME=$(hostname)
echo "Name of this machine is $HOSTNAME"

USER=$(whoami)
echo "I am $USER user"

dir=$(pwd)

echo "$dir"
