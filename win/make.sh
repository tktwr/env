#!/bin/bash

#======================================================
# variables
#======================================================
VSCODE=$APP_R_VSCODE

#======================================================
# functions
#======================================================
#------------------------------------------------------
# vscode
#------------------------------------------------------
f_10_vscode_diff() {
  popup-vimdiff.sh vscode/settings.json $VSCODE/settings.json
  pause.sh
  popup-vimdiff.sh vscode/keybindings.json $VSCODE/keybindings.json
}

f_11_vscode_push() {
  cd vscode
  cp settings.json $VSCODE
  cp keybindings.json $VSCODE
}

f_12_vscode_pull() {
  cd vscode
  cp $VSCODE/settings.json .
  cp $VSCODE/keybindings.json .
}

#------------------------------------------------------
# wsltty
#------------------------------------------------------
f_20_install_wsltty_config() {
  cd wsltty
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp config $wsltty_dir
}

#======================================================
# main
#======================================================
f_fzf_default() { f_10_vscode_diff; }
f_fzf_main "$@"
