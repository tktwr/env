#!/bin/bash

g_bin_name='fzf_rg.sh'

g_topdir=''
g_dirs=''

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] [dir...]"
  echo
  echo "OPTIONS"
  echo "  --help ... print help"
  echo "  --args ... print args"
  echo "  --root ... cd git root"
}

#------------------------------------------------------
git-cd-root() {
  g_topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$g_topdir" ]; then
    cd $g_topdir
  fi
}

#------------------------------------------------------
fzf_rg() {
  cmd="rg --column --line-number --no-heading --color=always --smart-case -- '' $@"
  eval $cmd | fzf --prompt 'rg> ' --ansi
}

#------------------------------------------------------
f_print_args() {
  echo "== [args] ============================================="
  echo "g_dirs : [$g_dirs]"
  echo "======================================================="
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      --help)
        f_help
        exit
        ;;
      --args)
        f_print_args 1>&2
        exit
        ;;
      --root)
        git-cd-root
        ;;
      *)
        g_dirs="$g_dirs $1"
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
fzf_rg $g_dirs
