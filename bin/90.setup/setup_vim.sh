#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_install_stubs() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git
}

f_install() {
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_update() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

#------------------------------------------------------
f_install_nvim() {
  sudo -E npm install -g neovim
}


#------------------------------------------------------
f_info() {
  echo
}

f_help() {
  echo "info          ... print info"
  echo "-----------   ... -----------------------------"
  echo "install_stubs ... install stubs"
  echo "install       ... install"
  echo "update        ... update"
  echo "-----------   ... -----------------------------"
  echo "install_nvim  ... install nvim"
  echo "-----------   ... -----------------------------"
  echo "help          ... print help"
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
