#!/bin/bash

#======================================================
# variables
#======================================================
ENV_DIR=~/MyRoaming/env

#======================================================
# functions
#======================================================
f_etc() {
  cd $ENV_DIR/etc
  ./make.sh init
  source $HOME/.bashrc
}

#------------------------------------------------------
f_init() {
  if [ ! -d $ENV_DIR ]; then
    echo "$ENV_DIR is not a directory"
    return
  fi

  f_etc
}

f_help() {
  echo "etc         ... etc"
  echo "----------- ... -----------------------------"
  echo "init        ... init"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help (default)"
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
