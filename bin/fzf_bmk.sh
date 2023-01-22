#!/bin/bash

g_bin_name='fzf_bmk.sh'
g_action='fzf'
g_pre_filter='-'
g_files=""

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] [file...]"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
  echo "  --src      ... print source"
  echo "  +          ... filter +"
}

#------------------------------------------------------
fzf_bmk_pre() {
  case $g_pre_filter in
    +)
      grep '^+ '
      ;;
    *)
      grep '^[-+] '
      ;;
  esac
}

fzf_bmk_post() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++' -e 's+> ++' -e 's+<CR>++'
}

fzf_bmk() {
  files=""
  for i in "$@"; do
    files="$files \
      $MY_ETC/bmk/$i \
      $MY_COMMON_SETTING/bmk/$i \
      $MY_DOTMY/bmk/$i \
      "
  done

  cmd="cat $files 2> /dev/null"
  if [ $g_action = 'fzf' ]; then
    eval "$cmd" | fzf_bmk_pre | fzf | fzf_bmk_post
  else
    eval "$cmd" | fzf_bmk_pre
  fi
}

#------------------------------------------------------
f_print_args() {
  echo "== [args] ============================================="
  echo "g_action     : $g_action"
  echo "g_pre_filter : $g_pre_filter"
  echo "g_files      : $g_files"
  echo "======================================================="
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --print-args)
        f_print_args 1>&2
        exit
        ;;
      --src)
        g_action='src'
        ;;
      +)
        g_pre_filter='+'
        ;;
      *)
        g_files="$g_files $1"
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
fzf_bmk $g_files
