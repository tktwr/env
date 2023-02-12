#!/bin/bash

g_bin_name='fzf_fd.sh'
g_action='--fzf'
g_opt='--strip-cwd-prefix'
g_topdir=''

#------------------------------------------------------
f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  --help        ... print help"
  echo "  --print-args  ... print args"
  echo "  --type=*      ... set type (f|d)"
  echo "  --max-depth=* ... set max depth (number)"
  echo "  --root        ... cd git root"
}

#------------------------------------------------------
git-cd-root() {
  g_topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$g_topdir" ]; then
    cd $g_topdir
  fi
}

#------------------------------------------------------
fzf_fdfind_exec() {
  fzf --prompt "$prompt" --preview 'preview.sh {}'
}

fzf_fdfind() {
  cmd="fdfind $g_opt"

  prompt='  '
  case $g_opt in
    *--type=d*)
      prompt=" $prompt"
      ;;
    *--type=f*)
      prompt=" $prompt"
      ;;
    *)
      prompt="  $prompt"
      ;;
  esac

  if [ -n "$g_topdir" ]; then
    prompt=" $prompt"
  fi

  case $g_action in
    --src)
      eval "$cmd"
      ;;
    --fzf)
      p=$(eval "$cmd" | fzf_fdfind_exec)
      if [ -n "$p" ]; then
        p=$(pathconv.sh unix "$p")
      fi
      echo $p
      ;;
  esac
}

#------------------------------------------------------
f_print_args() {
  echo "== [args] ============================================="
  echo "g_action     : $g_action"
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
      --src|--fzf|--fzf-post)
        g_action=$1
        ;;
      --type=*|--max-depth=*)
        g_opt="$g_opt $1"
        ;;
      --root)
        git-cd-root
        ;;
    esac
    shift
  done
}

#------------------------------------------------------
f_parse_args "$@"
fzf_fdfind
