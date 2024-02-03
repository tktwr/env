#!/bin/bash

#======================================================
# variables
#======================================================
conda_pkg="\
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
  conda install $conda_pkg
  #conda install -c conda-forge opencv
}

