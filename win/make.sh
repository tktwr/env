#!/bin/bash

#======================================================
# variables
#======================================================
VSCODE=$APP_VSCODE

#======================================================
# functions
#======================================================
#------------------------------------------------------
# vscode
#------------------------------------------------------
f_vscode_diff() {
  cd vscode
  popup-vimdiff.sh settings.json $VSCODE/settings.json
  popup-vimdiff.sh keybindings.json $VSCODE/keybindings.json
}

f_vscode_push() {
  cd vscode
  cp settings.json $VSCODE
  cp keybindings.json $VSCODE
}

f_vscode_pull() {
  cd vscode
  cp $VSCODE/settings.json .
  cp $VSCODE/keybindings.json .
}

#------------------------------------------------------
# wsltty
#------------------------------------------------------
f_install_wsltty_config() {
  cd wsltty
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp config $wsltty_dir
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
