#!/bin/bash

g_bin_name='fzf_fd.sh'

g_action='--fzf'
g_prompt='    '
g_fd_opt='--strip-cwd-prefix'
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
  echo "  --src         ... print source lines"
  echo "  --fzf         ... print the selected line by fzf"
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
fzf_fd_selector() {
  opt="--prompt '$g_prompt'"
  opt="$opt --preview 'preview.sh {}'"
  opt="$opt --preview-window 'hidden'"
  opt="$opt --header '[C-D:dir, C-F:file, C-T:preview, A-X:explorer, A-C:chrome, A-V:vscode]'"
  opt="$opt --bind 'ctrl-d:reload(fzf_fd.sh --src --type=d)'"
  opt="$opt --bind 'ctrl-f:reload(fzf_fd.sh --src --type=f)'"
  opt="$opt --bind 'ctrl-t:toggle-preview'"
  opt="$opt --bind 'alt-x:execute(te.sh {})'"
  opt="$opt --bind 'alt-c:execute(chrome.sh {})'"
  opt="$opt --bind 'alt-v:execute(vscode.sh {})'"
  eval "fzf $opt"
}

fzf_fd() {
  cmd="fdfind $g_fd_opt"

  if [ -n "$g_topdir" ]; then
    g_prompt=" $g_prompt"
  fi

  case $g_action in
    --src)
      eval "$cmd"
      ;;
    --fzf)
      p=$(eval "$cmd" | fzf_fd_selector)
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
  echo "g_action : [$g_action]"
  echo "g_prompt : [$g_prompt]"
  echo "g_fd_opt : [$g_fd_opt]"
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
      --src|--fzf)
        g_action=$1
        ;;
      --type=*|--max-depth=*)
        g_fd_opt="$g_fd_opt $1"
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
fzf_fd
