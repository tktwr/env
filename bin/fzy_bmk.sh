#!/bin/bash

rm_pre() {
  sed 's/^....//'
}

fzy_bmk_pre() {
  case $pre_filter in
    +)
      grep '^+ ' | rm_pre
      ;;
    *)
      grep '^[-+] ' | rm_pre
      ;;
  esac
}

fzy_bmk_post() {
  awk -F '|' '{print $2}' | sed -e 's+> ++' -e 's+<CR>++'
}

fzy_bmk() {
  local files="\
    $MY_ETC/bmk/$1 \
    $MY_COMMON_SETTING/bmk/$1 \
    $MY_DOTMY/bmk/$1 \
    "
  shift
  files="$files $@"
  cmd="cat $files 2> /dev/null"
  echo $(eval $cmd | fzy_bmk_pre | fzy | fzy_bmk_post)
}

#------------------------------------------------------
case "$1" in
  +)
    pre_filter=+
    shift
    fzy_bmk "$@"
    ;;
  *)
    fzy_bmk "$@"
    ;;
esac
