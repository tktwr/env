#!/bin/bash

f_preview() {
  file=$(eval "echo $1")
  if [ -f "$file" ]; then
    batcat -n --color=always "$file"
  elif [ -d "$file" ]; then
    LANG=C exa -lTF --icons --group-directories-first --level=1 "$file"
  fi
}

f_preview "$*"
