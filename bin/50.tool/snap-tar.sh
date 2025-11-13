#!/bin/bash
#
# snap-tar.sh dst_dir out_name dirs|files...

source common.sh

g_bin_name=`basename $0`
g_exec_flag=1
g_time_stamp=0
g_dst_dir=""
g_out_name="snap"
g_files=""

f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] dirs|files..."
  echo
  echo "OPTIONS"
  echo "  -h, --help                ... print help"
  echo "  -d, --dst-dir dir         ... set dst dir"
  echo "  -D, --dst-dir-date dir    ... set dst dir"
  echo "  -o, --out_name            ... set out name"
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
      -o|--out_name)
        shift
        g_out_name="$1"
        ;;
      -d|--dst-dir)
        shift
        g_dst_dir="$1"
        ;;
      -D|--dst-dir-date)
        shift
        g_dst_dir="$1/$(f_get_date)"
        ;;
      *)
        g_files="$g_files $1"
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "-- [args] ---------------------------------------------"
  echo "g_dst_dir    : $g_dst_dir"
  echo "g_out_name   : $g_out_name"
  echo "g_files      : $g_files"
  echo "g_time_stamp : $g_time_stamp"
  echo "g_exec_flag  : $g_exec_flag"
  echo "-------------------------------------------------------"
}

f_tar() {
  if [ $g_time_stamp -eq 1 ]; then
    out_tar=$(f_get_snapfname ${g_out_name}.tar.gz)
  else
    out_tar=${g_out_name}.tar.gz
  fi

  f_eval "tar czf $out_tar $@" $g_exec_flag
  f_mkdir "$g_dst_dir" $g_exec_flag
  if [ -f $out_tar -o $g_exec_flag -eq 0 ]; then
    f_eval "mv $out_tar $g_dst_dir" $g_exec_flag
  fi
}

f_parse_args "$@"
f_print_args
f_tar "$g_files"
