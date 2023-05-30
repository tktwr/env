#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_install_min() {
  winget.exe install sharkdp.fd
  winget.exe install sharkdp.bat
  winget.exe install junegunn.fzf
  winget.exe install BurntSushi.ripgrep.MSVC
}

#------------------------------------------------------
f_help() {
  echo "install_min ... install min"
  echo "----------- ... -----------------------------"
  echo "help        ... print help"
}

f_default() {
  f_help
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
