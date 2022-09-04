#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================

#------------------------------------------------------
f_help() {
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
