#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
#------------------------------------------------------
# vim
#------------------------------------------------------
f_install_vim_stubs() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git
}

f_install_vim() {
  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_update_vim() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

#------------------------------------------------------
# nvim
#------------------------------------------------------
f_install_nvim() {
  sudo -E npm install -g neovim
}

#------------------------------------------------------
# nodejs
#------------------------------------------------------
f_install_nodejs() {
  install-nodejs.sh
}

f_install_wsltty_config() {
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp $MY_ENV/setup/win/wsltty/config $wsltty_dir
}

#------------------------------------------------------
f_print_env() {
  print-env.sh
}

f_print_path() {
  print-path.sh
}

f_print_version() {
  print-version.sh
}

#------------------------------------------------------
f_set_hwclock() {
  set-hwclock.sh
}

#------------------------------------------------------
f_setup_ubuntu() {
  eval_fzf_cmd setup_ubuntu.sh
}

f_setup_python() {
  eval_fzf_cmd setup_python.sh
}

f_setup_winget() {
  eval_fzf_cmd setup_winget.sh
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
