#!/bin/bash
#con1 && con2  || con3
age=18
[[ $age -ge 18 ]] && echo "You can vote" || echo "You can't vote"
