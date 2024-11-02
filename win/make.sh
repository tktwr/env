#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
#------------------------------------------------------
# vscode
#------------------------------------------------------
f_10_vscode_diff() {
  popup-vimdiff.sh vscode/settings.json $APP_R_VSCODE/settings.json
  pause.sh
  popup-vimdiff.sh vscode/keybindings.json $APP_R_VSCODE/keybindings.json
}

f_11_vscode_push() {
  cp vscode/settings.json $APP_R_VSCODE
  cp vscode/keybindings.json $APP_R_VSCODE
}

f_12_vscode_pull() {
  cp $APP_R_VSCODE/settings.json vscode
  cp $APP_R_VSCODE/keybindings.json vscode
}

#------------------------------------------------------
# wsltty
#------------------------------------------------------
f_20_install_wsltty_config() {
  cp wsltty/config $APP_R/wsltty
}

#======================================================
# main
#======================================================
f_fzf_default() { f_10_vscode_diff; }
f_fzf_main "$@"
