#!/bin/bash

#======================================================
# functions
#======================================================
f_all() {
  cp bashrc_all.sh $HOME/.bashrc
  ./expand_env.sh > $HOME/.my/env
  env.sh > $HOME/.my/hostname
}

f_min() {
  cp bashrc_min.sh $HOME/.bashrc
}

#------------------------------------------------------
f_help() {
  echo "all         ... full settings (default)"
  echo "min         ... minimum settings"
  echo "help        ... print this help"
}

f_default() {
  f_all
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"
