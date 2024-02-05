#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_10_vim_plug_update() { f_vim_plug_update; }
f_11_sync_time()       { sync-time.sh; }
#------------------------------------------------------
f_print_env()     { print-env.sh; }
f_print_path()    { print-path.sh; }
f_print_version() { print-version.sh; }
#------------------------------------------------------
setup_files="\
  $MY_BIN/90.setup/setup_*.sh \
  $SYS_CONFIG_HOME/lconfig/bin/setup_*.sh \
  "
for setup_file in $setup_files; do
  if [ -f $setup_file ]; then
    source $setup_file
  fi
done

#======================================================
# main
#======================================================
f_fzf_main "$@"
