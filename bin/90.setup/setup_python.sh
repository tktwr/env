#!/bin/bash

#======================================================
# variables
#======================================================
pip_pkg_min="\
python-language-server \
pylint \
flake8 \
autopep8 \
pyinstaller \
pynvim \
"
pip_pkg_dev="\
parse \
numpy \
opencv-python \
matplotlib \
tkinterdnd2 \
"
pip_pkg_dev_ext="\
gradio \
scipy \
scikit-learn \
tensorboard \
"
pip_pkg_torch="\
torch torchvision torchaudio xformers --index-url https://download.pytorch.org/whl/cu118 \
"

#======================================================
# functions
#======================================================
f_venv_create() {
  local dir=.venv
  if [ ! -d "$dir" ]; then
    echo "python -m venv $dir"
    python -m venv $dir
  fi
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
  pip install $pip_pkg_min
}

f_pip_install_dev() {
  pip install $pip_pkg_dev
}

f_pip_install_torch() {
  pip install $pip_pkg_torch
}

