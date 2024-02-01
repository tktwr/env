#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_install_vim_stubs() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git
}

f_install_vim_plug() {
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_update_vim_plug() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

f_upgrade_vim_plug() {
  vim -c 'PlugUpgrade'
}

#------------------------------------------------------
# nvim
#------------------------------------------------------
f_install_nvim() {
  sudo -E npm install -g neovim
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
