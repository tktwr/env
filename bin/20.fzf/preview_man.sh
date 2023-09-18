#!/bin/bash

# preview_man.sh "keyword [(section)]"

f_batcat() { batcat -l=man -p --color=always "$@"; }
f_cat()    { cat "$@"; }

f_preview_man() {
  man $(echo "$*" | awk '{print $2,$1}' | sed 's/[()]//g') | f_$SYS_CAT_EXE
}

f_preview_man "$*"
