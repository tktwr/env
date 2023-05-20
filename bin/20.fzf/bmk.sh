#!/bin/bash

#------------------------------------------------------
# global variables
#------------------------------------------------------
g_bmk_pre_filter='-'
g_bmk_files=""

#------------------------------------------------------
# functions
#------------------------------------------------------
has_bin() {
  which $1 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo true
  else
    echo false
  fi
}

bmk_pre() {
  case $g_bmk_pre_filter in
    +)
      grep '^+ '
      ;;
    *)
      grep '^[-+] '
      ;;
  esac
}

bmk() {
  files=""
  for i in "$@"; do
    files="$files \
      $MY_ETC/bmk/$i \
      $MY_COMMON_SETTING/bmk/$i \
      $MY_DOTMY/bmk/$i \
      "
  done

  if $(has_bin batcat); then
    cat $files 2> /dev/null | bmk_pre | batcat -l bash -pp --color=always
  else
    cat $files 2> /dev/null | bmk_pre
  fi
}

#------------------------------------------------------
# main
#------------------------------------------------------
f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      +)
        g_bmk_pre_filter='+'
        ;;
      *)
        g_bmk_files="$g_bmk_files $1"
        ;;
    esac
    shift
  done
}

f_parse_args "$@"
if [ -n "$g_bmk_files" ]; then
  bmk $g_bmk_files
fi
