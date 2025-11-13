#!/bin/bash
#
# EXAMPLE
#   cd git_dir
#   git-tar.sh -D dst_dir
#
# OUTPUT:
#   dst_dir/DATE/git_dir[-date-time-branch-commit].tar.gz

source common.sh

g_bin_name=`basename $0`
g_exec_flag=1
g_time_stamp=0
g_dst_dir=""

f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help                ... print help"
  echo "  -d, --dst-dir dir         ... set dst dir"
  echo "  -D, --dst-dir-date dir    ... set dst dir"
  echo "  -t, --time_stamp          ... add time stamp in filename"
  echo "  -n, --no-exec             ... no execution"
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      -n|--no-exec)
        g_exec_flag=0
        ;;
      -t|--time_stamp)
        g_time_stamp=1
        ;;
      -d|--dst-dir)
        shift
        g_dst_dir="$1"
        ;;
      -D|--dst-dir-date)
        shift
        g_dst_dir="$1/$(f_get_date)"
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "-- [args] ---------------------------------------------"
  echo "g_dst_dir    : $g_dst_dir"
  echo "g_time_stamp : $g_time_stamp"
  echo "g_exec_flag  : $g_exec_flag"
  echo "-------------------------------------------------------"
}

f_tar() {
  dirname=$(basename $(pwd))
  if [ $g_time_stamp -eq 1 ]; then
    fname=$(f_get_git_snapfname $dirname).tar.gz
  else
    fname="$dirname.tar.gz"
  fi

  f_eval "git.sh archive HEAD --prefix=$dirname/ --output=$fname" $g_exec_flag
  f_mkdir "$g_dst_dir" $g_exec_flag
  if [ -f $fname -o $g_exec_flag -eq 0 ]; then
    f_eval "mv $fname $g_dst_dir" $g_exec_flag
  fi
}

f_parse_args "$@"
f_print_args
f_tar
