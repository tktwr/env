#!/bin/bash

#======================================================
# variables
#======================================================
pkg_min="\
python-language-server \
pylint \
flake8 \
autopep8 \
pyinstaller \
pynvim \
"

pkg_dev="\
parse \
numpy \
opencv-python \
matplotlib \
tkinterdnd2 \
"

pkg_dev_ext="\
scipy \
sklearn \
tensorboard \
"

# pytorch with CUDA 10.2
pkg_torch182_cu102="\
--trusted-host download.pytorch.org \
torch==1.8.2+cu102 torchvision==0.9.2+cu102 torchaudio===0.8.2 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html \
"

#======================================================
# functions
#======================================================
f_install_min() {
  pip install wheel
  pip install $pkg_min
}

f_install_dev() {
  pip install $pkg_dev
}

f_install_torch() {
  pip install $pkg_torch
}

f_upgrade() {
  python_exe=${MY_PYTHON_EXE:-"python"}
  $python_exe -m pip install --upgrade pip
}

#------------------------------------------------------
f_help() {
  echo "install_min   ... install min pkg"
  echo "install_dev   ... install dev pkg"
  echo "install_torch ... install torch pkg"
  echo "upgrade       ... upgrade pip"
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
