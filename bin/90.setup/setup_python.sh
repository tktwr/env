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
f_venv_create_default() {
  mypython.sh --create-venv default
  source $HOME/.bashrc
}

f_venv_info() {
  mypython.sh --print-env
  echo "VENVS:"
  mypython.sh --list-venv
}

#------------------------------------------------------
f_pip_upgrade() {
  pip install --upgrade pip
}

f_pip_upgrade_old() {
  python_exe=${MY_PYTHON_EXE:-"python"}
  $python_exe -m pip install --upgrade pip
}

#------------------------------------------------------
f_pip_install_min() {
  pip install wheel
  pip install $pkg_min
}

f_pip_install_dev() {
  pip install $pkg_dev
}

f_pip_install_torch() {
  pip install $pkg_torch
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
