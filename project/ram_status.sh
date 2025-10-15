#!/bin/bash
FREE_MEM_MB=$(free -mt | grep "Total" | awk '{print $4}')
FREE_MEM_GB=$(free -h -mt | grep "Total" | awk '{gsub("Gi","",$4);print $4}'
)
TH=2000
TH2=2
if [[ $FREE_MEM_MB -lt $TH || $(echo "$FREE_MEM_GB < $TH2" | bc -l) -eq 1 ]]; then
  echo "WARNING, RAM is running low"
else
  echo "Ram Space is sufficient - $FREE_MEM_MB MB OR $FREE_MEM_GB Gi"
fi


