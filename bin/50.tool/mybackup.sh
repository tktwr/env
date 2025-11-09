#!/bin/bash

source common.sh

g_bin_name=`basename $0`
g_exec_flag=1
g_snap_name=0
g_backup_dir="$MY_BACKUP"
g_files=""

f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options] file|dir"
  echo
  echo "OPTIONS"
  echo "  -h, --help                ... print help"
  echo "  -d, --backup-dir dir      ... set backup dir"
  echo "  -D, --backup-dir-date dir ... set backup dir"
  echo "  -s, --snap_name           ... snap name"
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
      -s|--snap_name)
        g_snap_name=1
        ;;
      -d|--backup-dir)
        shift
        g_backup_dir="$1"
        ;;
      -D|--backup-dir-date)
        shift
        g_backup_dir="$1/$(f_get_date)"
        ;;
      *)
        g_files="$g_files $1"
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "== [args] ============================================="
  echo "g_backup_dir : $g_backup_dir"
  echo "g_files      : $g_files"
  echo "g_snap_name  : $g_snap_name"
  echo "g_exec_flag  : $g_exec_flag"
  echo "======================================================="
}

f_backup() {
  for i in $*; do
    if [ $g_snap_name -eq 1 ]; then
      ofname=`f_get_git_snapfname $i`
    else
      ofname="$i"
    fi
    f_mkdir "$g_backup_dir" $g_exec_flag
    f_eval "cp -a $i $g_backup_dir/$ofname" $g_exec_flag
  done
}

f_parse_args "$@"
f_print_args
f_backup "$g_files"

