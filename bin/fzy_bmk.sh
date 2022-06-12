#!/bin/bash

bmk_pre() {
  grep -v '^#' | grep -v '\-\-\-'
}

bmk_post() {
  awk -F '|' '{print $2}' | sed -e 's+> ++' -e 's+<CR>++'
}

fzy_bmk() {
  local files="\
    $MY_ETC/bmk/$1 \
    $MY_COMMON_SETTING/bmk/$1 \
    $MY_DOTMY/bmk/$1 \
    $HOME/.$1 \
    "
  shift
  files="$files $@"
  cmd="cat $files 2> /dev/null"
  echo $(eval $cmd | bmk_pre | fzy | bmk_post)
}

#------------------------------------------------------
fzy_bmk "$@"

