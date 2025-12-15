#!/bin/bash

f_laod_funcs() {
  cmd_files="\
    $MY_BIN/90.setup/func_*.sh \
    $SYS_CONFIG_HOME/lconfig/bin/func_*.sh \
    "
  for cmd_file in $cmd_files; do
    if [ -f $cmd_file ]; then
      source $cmd_file
    fi
  done
}

f_laod_funcs
