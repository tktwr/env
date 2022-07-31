#!/bin/bash

#======================================================
# variables
#======================================================
pkg_vim="\
wheel \
python-language-server \
pylint \
flake8 \
pyinstaller \
"

pkg_lib="\
parse \
numpy \
opencv-python \
matplotlib \
scipy \
sklearn \
tensorboard \
"

# pytorch with CUDA 10.2
pkg_torch="\
--trusted-host download.pytorch.org \
torch==1.8.2+cu102 torchvision==0.9.2+cu102 torchaudio===0.8.2 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html \
"

#======================================================
# functions
#======================================================
f_install_vim() {
  pip install $pkg_vim
}

f_install_lib() {
  pip install $pkg_lib
}

f_install_torch() {
  pip install $pkg_torch
}

#------------------------------------------------------
f_help() {
  echo "install_vim   ... install vim"
  echo "install_lib   ... install lib"
  echo "install_torch ... install torch"
  echo "help          ... print help"
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

