#!/bin/bash

pkg_vim="\
wheel \
python-language-server \
pylint \
flake8 \
"

pkg_lib="\
opencv-python \
matplotlib \
numpy \
scipy \
sklearn \
parse \
tensorboard \
"

# pytorch with CUDA 10.2
pkg_torch="\
torch===1.6.0 torchvision===0.7.0 -f https://download.pytorch.org/whl/torch_stable.html \
"

pip install $pkg_vim $pkg_lib
pip install $pkg_torch

