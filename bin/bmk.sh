#!/bin/bash

fzy_bmk_filter() {
  grep -v '^#' | grep -v '\-\-\-' | fzy | awk -F '|' '{print $2}'
}

fzy_cmd_filter() {
  sed -e 's+> ++' -e 's+<CR>++'
}

fzy_arg_bmk() {
  local files="$MY_DOTMY/$1 \
               $MY_COMMON_SETTING/$1 \
               $MY_BMK/$1 \
               "
  echo $(cat $files 2> /dev/null | fzy_bmk_filter | fzy_cmd_filter)
}

fzy_arg_bmk $1

