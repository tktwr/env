#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_wsl_install()          { wsl.exe --install Ubuntu; }
f_wsl_update()           { wsl.exe --update; }
f_wsl_shutdown()         { wsl.exe --shutdown; }
f_wsl_list_installable() { wsl.exe -l -o; }

f_wsl_info() {
  wsl.exe --version
  wsl.exe --status
  wsl.exe -l -v
}

