#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_install_nodejs() {
  install-nodejs.sh
}

f_install_wsltty_config() {
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp $MY_ENV/setup/win/wsltty/config $wsltty_dir
}

#------------------------------------------------------
f_info() {
  echo
}

f_help() {
  echo "info                  ... print info"
  echo "-----------           ... -----------------------------"
  echo "install_nodejs        ... install nodejs"
  echo "install_wsltty_config ... install wsltty config"
  echo "-----------           ... -----------------------------"
  echo "help                  ... print help"
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
