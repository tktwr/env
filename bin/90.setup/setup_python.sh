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
f_venv_create() {
  local dir=.venv
  if [ ! -d "$dir" ]; then
    echo "python3 -m venv $dir"
    python3 -m venv $dir
  fi
  source $dir/bin/activate
}

f_venv_info() {
  which python
  which pip
}

#------------------------------------------------------
f_pip_upgrade() {
  pip install --upgrade pip
}

f_pip_upgrade_old() {
  python -m pip install --upgrade pip
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
