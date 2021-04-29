#!/bin/bash

g_base_dir=$(pwd)
g_bin_name=`basename $0`

declare -A g_opts
g_opts["status"]=0
g_opts["log"]=0
g_opts["log_submodule"]=0
g_opts["args"]=""

f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help            ... print help"
  echo "  --status              ... print status"
  echo "  --log n               ... print n logs"
  echo "  --log-submodule n     ... print n submodule's logs"
}

f_git_status() {
  if [ ${g_opts["status"]} ]; then
    echo "---"
    git status -s
  fi
}

f_log() {
  echo "=== [$g_base_dir] ==="
  git graph "$@"
  echo
  f_git_status
}

f_log_submodule() {
  dirs=$(git submodule | awk '{print $2}')
  for i in $dirs; do
    echo "====== [$i] ======"
    git diff --submodule "$i" | head -1
    cd $i
    git graph "$@"
    echo
    f_git_status
    cd $g_base_dir
  done
}

f_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --status)
        g_opts["status"]=1
        ;;
      --log)
        shift
        g_opts["log"]=-$1
        ;;
      --log-submodule)
        shift
        g_opts["log_submodule"]=-$1
        ;;
      *)
        g_opts["args"]="${g_opts["args"]} $1"
        ;;
    esac
    shift
  done
}

f_args "$@"

if [ -n ${g_opts["log"]} ]; then
  f_log ${g_opts["log"]} ${g_opts["args"]}
fi

if [ -n ${g_opts["log_submodule"]} ]; then
  f_log_submodule ${g_opts["log_submodule"]} ${g_opts["args"]}
fi

