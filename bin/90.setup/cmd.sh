#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================

#------------------------------------------------------
cmd_files="\
  $MY_BIN/90.setup/cmd_*.sh \
  $SYS_CONFIG_HOME/lconfig/bin/cmd_*.sh \
  "
for cmd_file in $cmd_files; do
  if [ -f $cmd_file ]; then
    source $cmd_file
  fi
done

#======================================================
# main
#======================================================
f_fzf_main "$@"
