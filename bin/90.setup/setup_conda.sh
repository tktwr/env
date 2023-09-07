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
f_conda_install() {
  conda install $pkg
  #conda install -c conda-forge opencv
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
