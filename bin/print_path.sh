#!/bin/sh

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] [path]"
  echo
  echo "OPTIONS"
  echo "  -h, --help   print help"
  echo "  -p, --path   print path"
  echo
}

f_format_path() { sed 's+:+\n+g'; }

f_print_path() {
  echo "SYS_PATH"
  echo "$SYS_PATH" | f_format_path
  echo
  echo "PATH"
  echo "$PATH" | f_format_path
}

if [ $# -eq 0 ]; then
  # work as a filter
  f_format_path
else
  case $1 in
  -h|--help)
    f_help
    ;;
  -p|--path)
    f_print_path
    ;;
  *)
    echo "$*" | f_format_path
    ;;
  esac
fi

