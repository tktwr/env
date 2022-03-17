#!/bin/bash

pkg_vim="\
wheel \
python-language-server \
pylint \
flake8 \
"

pkg_lib="\
numpy \
opencv-python \
matplotlib \
scipy \
sklearn \
parse \
tensorboard \
"

# pytorch with CUDA 10.2
pkg_torch="\
--trusted-host download.pytorch.org \
torch==1.8.2+cu102 torchvision==0.9.2+cu102 torchaudio===0.8.2 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html \
"

pip install $pkg_vim
pip install $pkg_lib
pip install $pkg_torch

