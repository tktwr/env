#!/bin/bash

f_batcat() { batcat -n --color=always "$@"; }
f_cat()    { cat "$@"; }

f_preview() {
  # expand env variables
  file=$(eval "echo $*")

  if [ -d "$file" ]; then
    if [ $COLUMNS -ge 80 ]; then
      opt='-l'
    fi
    LANG=C ls -F --color=always $opt "$file"
  elif [ -f "$file" ]; then
    f_$SYS_CAT_EXE "$file"
  fi
}

f_preview "$*"
