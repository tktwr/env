#!/bin/bash

fzy_fzy_pre() {
  grep -v '^#'
}

fzy_fzy_post() {
  awk -F '|' '{print $3}'
}

fzy_fzy() {
  local files="$MY_DOTMY/fzy/dir.txt \
               $MY_COMMON_SETTING/fzy/dir.txt \
               $MY_ETC/fzy/dir.00.sys.txt \
               $MY_ETC/fzy/dir.01.usr.txt \
               $MY_ETC/fzy/dir.txt \
               "
  cmd="cat $files 2> /dev/null"
  echo $(eval $cmd | fzy_fzy_pre | fzy | fzy_fzy_post)
}

#------------------------------------------------------
fzy_fzy "$@"

