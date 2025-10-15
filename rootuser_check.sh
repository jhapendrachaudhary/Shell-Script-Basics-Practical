#!bun/bash
#checking user is root or not

if [[ $UID -eq 0 ]]; then
  echo "I am root user"
else
  echo "I am not root user"
fi
