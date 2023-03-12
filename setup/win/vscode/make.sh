#!/bin/bash

#======================================================
# variables
#======================================================
VSCODE=$SYS_WIN_HOME/AppData/Roaming/Code/User

#======================================================
# functions
#======================================================
f_vimdiff() {
  vimdiff.sh settings.json $VSCODE/settings.json
  vimdiff.sh keybindings.json $VSCODE/keybindings.json
}

f_push() {
  cp settings.json $VSCODE
  cp keybindings.json $VSCODE
}

f_pull() {
  cp $VSCODE/settings.json .
  cp $VSCODE/keybindings.json .
}

#------------------------------------------------------
f_help() {
  echo "vimdiff"
  echo "push"
  echo "pull"
  echo "help"
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
