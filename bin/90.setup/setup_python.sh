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
flask \
flask_cors \
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
scikit-image \
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
  python -m pip install --upgrade pip
  #pip install --upgrade pip
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
#------------------------------------------------------
f_poetry_ls_config() {
  poetry config --list
}
f_poetry_set_config() {
  poetry config virtualenvs.in-project true
}
#------------------------------------------------------
f_poetry_new() {
  poetry new myproj
}
f_poetry_init() {
  poetry init -n
}
f_poetry_install() {
  poetry install
}
