#!/bin/bash

#======================================================
# variables
#======================================================
pkg="\
numpy \
opencv \
matplotlib \
scikit-image \
scikit-learn \
pillow \
json5 \
python-graphviz graphviz \
"

#======================================================
# functions
#======================================================
f_install() {
  conda install $pkg
  #conda install -c conda-forge opencv
}

#------------------------------------------------------
f_info() {
  echo
}

f_help() {
  echo "info        ... print info"
  echo "----------- ... -----------------------------"
  echo "install     ... install"
  echo "----------- ... -----------------------------"
  echo "help        ... print help"
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
