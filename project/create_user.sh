#!/bin/bash
if [[ "${UID}" -ne 0 ]]
then
  echo "Please run as a sudo or root user."
  exit 1
fi

if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  echo "Create a user with name USER_NAME and comments field of COMMENT"
 exit 1
fi

USER_NAME="${1}"

shift
COMMENT="${@}"

PASSWORD=$(date +%s%N)

useradd -c "$COMMENT" -m $USER_NAME

if [[ $? -ne 0 ]]
then
  echo "Account could not be created"
  exit 1
fi

echo "$USER_NAME:$PASSWORD" | chpasswd

if [[ $? -ne 0 ]]
then 
  echo "Password could not be set"
  exit 1
fi

passwd -e $USER_NAME

echo 
echo "Username: $USER_NAME"
echo 
echo "Psssword: $PASSWORD"
echo
echo "Hostname: $hostname"
echo "Welcome to Linux as user"
