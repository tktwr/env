#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_10_vim_plug_update() { setup_vim.sh f_vim_plug_update; }
f_11_sync_time()       { sync-time.sh; }
#------------------------------------------------------
f_print_env()     { print-env.sh; }
f_print_path()    { print-path.sh; }
f_print_version() { print-version.sh; }
f_print_netsh()   { print-netsh.sh; }
#------------------------------------------------------
for setup_file in $MY_BIN/90.setup/setup_*.sh; do
  source $setup_file
done

#======================================================
# main
#======================================================
f_fzf_main "$@"
