#!/bin/bash

fzf_bmk_pre() {
  case $pre_filter in
    +)
      grep '^+ '
      ;;
    *)
      grep '^[-+] '
      ;;
  esac
}

fzf_bmk() {
  local files="\
    $MY_ETC/bmk/$1 \
    $MY_COMMON_SETTING/bmk/$1 \
    $MY_DOTMY/bmk/$1 \
    "
  shift
  files="$files $@"
  cmd="cat $files 2> /dev/null"
  eval "$cmd" | fzf_bmk_pre
}

#------------------------------------------------------
case "$1" in
  +)
    pre_filter=+
    shift
    ;;
esac

fzf_bmk "$@"
