#!/bin/bash

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name - a filter to format a path"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name unix|win"
  echo
}

f_format_path_unix() {
  sed 's+:+\n+g'
}

f_format_path_win() {
  sed 's+;+\n+g'
}

FORMAT=f_format_path_${1:-"unix"}
eval $FORMAT
