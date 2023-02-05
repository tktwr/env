#!/bin/bash

g_bin_name='fzf_fd.sh'
g_opt="--strip-cwd-prefix"

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  --help         ... print help"
  echo "  --print-args   ... print args"
  echo "  --type=*       ... set type (f|d)"
  echo "  --max-depth=*  ... set max depth (number)"
  echo "  -g, --git-root ... cd git root"
}

#------------------------------------------------------
git-cd-root() {
  topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$topdir" ]; then
    cd $topdir
  fi
}

#------------------------------------------------------
fzf_find() {
  cmd="fdfind $g_opt"

  prompt='  '
  case $g_opt in
    *--type=d*)
      prompt='   '
      ;;
    *--type=f*)
      prompt='   '
      ;;
  esac

  p=$(eval $cmd | fzf --prompt "$prompt")
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
f_print_args() {
  echo "== [args] ============================================="
  echo "g_opt        : $g_opt"
  echo "======================================================="
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      --help)
        f_help
        exit
        ;;
      --print-args)
        f_print_args 1>&2
        exit
        ;;
      --type=*|--max-depth=*)
        g_opt="$g_opt $1"
        ;;
      -g|--git-root)
        git-cd-root
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
fzf_find
