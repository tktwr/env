#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
}

f_help() {
  echo "default"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"
