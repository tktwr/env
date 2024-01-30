#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_10_update_vim_plug() { setup_vim.sh f_update_vim_plug; }
f_11_sync_time()       { sync-time.sh; }
#------------------------------------------------------
f_print_env()     { print-env.sh; }
f_print_path()    { print-path.sh; }
f_print_version() { print-version.sh; }
f_print_netsh()   { print-netsh.sh; }
#------------------------------------------------------
f_setup_winget()  { eval_fzf_cmd setup_winget.sh; }
f_setup_wsl()     { eval_fzf_cmd setup_wsl.sh; }
f_setup_ubuntu()  { eval_fzf_cmd setup_ubuntu.sh; }
f_setup_python()  { eval_fzf_cmd setup_python.sh; }
f_setup_ssh()     { eval_fzf_cmd setup_ssh.sh; }
f_setup_docker()  { eval_fzf_cmd setup_docker.sh; }
f_setup_nodejs()  { eval_fzf_cmd setup_nodejs.sh; }
f_setup_vim()     { eval_fzf_cmd setup_vim.sh; }
f_setup_misc()    { eval_fzf_cmd setup_misc.sh; }

#======================================================
# main
#======================================================
f_fzf_main "$@"
