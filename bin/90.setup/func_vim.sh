#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_vim_install_stubs() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git
}

f_vim_plug_install() {
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_vim_plug_update() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

f_vim_plug_upgrade() {
  vim -c 'PlugUpgrade'
}

#------------------------------------------------------
# nvim
#------------------------------------------------------
f_nvim_install() {
  sudo -E npm install -g neovim
}

