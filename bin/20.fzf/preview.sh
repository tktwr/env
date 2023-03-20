#!/bin/bash

fzf_preview() {
  file=$(eval "echo $1")
  if [ -f "$file" ]; then
    batcat -n --color=always "$file"
  elif [ -d "$file" ]; then
    if [ $COLUMNS -ge 80 ]; then
      opt='-l'
    fi
    LANG=C ls -F --color=always $opt "$file"
  fi
}

fzf_preview "$*"
