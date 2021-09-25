#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
  cp bashrc_all.sh $HOME/.bashrc
  ./expand_env.sh > $HOME/.bashrc.env
}

f_min() {
  cp bashrc_min.sh $HOME/.bashrc
}

f_help() {
  echo "default"
  echo "min"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

