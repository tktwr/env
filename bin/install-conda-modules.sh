#!/bin/bash

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

conda install $pkg
#conda install -c conda-forge opencv

