#!/bin/bash

# expand env variables
line=$(eval "echo $*")

if [ -d "$line" ]; then
  if [ $COLUMNS -ge 80 ]; then
    opt='-l'
  fi
  LANG=C ls -F --color=always $opt "$line"
elif [ -f "$line" ]; then
  batcat -n --color=always "$line"
fi
