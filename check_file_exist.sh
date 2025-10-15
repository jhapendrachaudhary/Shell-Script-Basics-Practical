#!/bin/bash
#folder check exist or not
#if [ -d folder_name ] if folder exists
#[ ! -d folder_name ] if folder not exists
#
#file check exist or not
#if [ -f file_name ] if file exits
#if [ ! -f file_name ] if file not exits


FILEPATH="/home/unknown/Documents/myscript/args.sh"
if [[ -f $FILEPATH ]]
then
  echo "file exist"
else
  touch "$FILEPATH"
  echo "file created.."
fi


