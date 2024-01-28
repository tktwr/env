#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_wsl_install()          { wsl.exe --install -d Ubuntu; }
f_wsl_update()           { wsl.exe --update; }
f_wsl_list_installed()   { wsl.exe -l -v; }
f_wsl_list_installable() { wsl.exe -l -o; }

#======================================================
# main
#======================================================
f_fzf_main "$@"
