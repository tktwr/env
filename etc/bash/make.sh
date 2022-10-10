#!/bin/bash

#======================================================
# functions
#======================================================
f_all() {
  ./make_hostname.sh > $HOME/.my/hostname.sh
  ./make_env.sh > $HOME/.my/env.sh
  cp bashrc_all.sh $HOME/.bashrc
}

f_min() {
  ./make_hostname.sh > $HOME/.my/hostname.sh
  cp bashrc_min.sh $HOME/.bashrc
}

f_zero() {
  cp bashrc_zero.sh $HOME/.bashrc
}

#------------------------------------------------------
f_help() {
  echo "all         ... full settings (default)"
  echo "min         ... minimum settings"
  echo "zero        ... minimum settings without any dependencies"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help"
}

f_default() {
  f_all
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
