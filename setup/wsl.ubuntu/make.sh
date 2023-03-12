#!/bin/bash

#======================================================
# variables
#======================================================
SYS_WIN_HOME=/mnt/c/Users/Takeh
MY_ENV=~/MyRoaming/env

pkg_min="\
vim \
fzf \
bat \
fd-find \
ripgrep \
zip unzip \
universal-ctags \
eblook \
python3-pip \
python3-venv \
"
pkg_ext="\
vim-gtk3 \
neovim \
imagemagick \
img2pdf \
fontforge \
subversion \
ncdu \
neofetch \
btop \
ncal \
googler \
"
pkg_dev="\
cmake \
clang \
clangd \
clang-format \
libglfw3-dev \
libopencv-dev \
python3-tk \
python3-opencv \
python3-doc \
"
pkg_not_install="\
blender \
nvidia-cuda-toolkit \
baobab \
nodejs npm \
exa \
"

#======================================================
# functions
#======================================================
f_info() {
  echo "SYS_WIN_HOME = $SYS_WIN_HOME"
  echo "MY_ENV       = $MY_ENV"
}

f_check() {
  cd

  if [ ! -d "WinHome" ]; then
    echo "make WinHome dir"
    ln -s $SYS_WIN_HOME WinHome
  else
    echo "WinHome [OK]"
  fi

  if [ ! -d $MY_ENV ]; then
    echo "$MY_ENV is not a directory"
    exit
  else
    echo "MY_ENV [OK]"
  fi
}

#------------------------------------------------------
f_init() {
  f_check

  f_update_apt
  f_install_min

  f_wsltty
  f_etc_init
}

f_wsltty() {
  wsltty_dir=$(wslpath -au $APPDATA/wsltty)
  cp $MY_ENV/setup/win/wsltty/config $wsltty_dir
}

f_etc_init() {
  cd $MY_ENV/etc
  ./make.sh init
  source $HOME/.bashrc
}

#------------------------------------------------------
f_install_min() {
  sudo -E apt install $pkg_min
}

f_install_ext() {
  sudo -E apt install $pkg_ext
}

f_install_dev() {
  sudo -E apt install $pkg_dev
}

#------------------------------------------------------
f_update_apt() {
  sudo -E apt update
  sudo -E apt upgrade
  sudo -E apt autoremove
}

f_update_vim() {
  vim -c 'PlugUpdate'
  vim -c 'CocUpdate'
}

f_update_pip() {
  pip install --upgrade pip
}

#------------------------------------------------------
f_python_venv() {
  mypython.sh --create-venv torch
  source $HOME/.bashrc

  if [ $MY_PYTHON_VENV = "torch" ]; then
    pip-upgrade.sh
    pip-install.sh install_min
  fi
}

f_nodejs() {
  node-install.sh
}

f_vim() {
  # LSP for python for cv2, matplotlib, etc.
  cd $MY_GITHUB
  git clone https://github.com/microsoft/python-type-stubs.git

  vim -c 'PlugInstall'
  vim -c 'MyCocInstall'
}

f_nvim() {
  sudo -E npm install -g neovim
}

#------------------------------------------------------
f_help() {
  echo "info        ... info"
  echo "check       ... check"
  echo "----------- ... -----------------------------"
  echo "init        ... init"
  echo "wsltty      ... wsltty"
  echo "etc_init    ... etc_init"
  echo "----------- ... -----------------------------"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "install_dev ... install_dev"
  echo "----------- ... -----------------------------"
  echo "update_apt  ... update_apt"
  echo "update_vim  ... update_vim"
  echo "update_pip  ... update_pip"
  echo "----------- ... -----------------------------"
  echo "python_venv ... python_venv"
  echo "nodejs      ... nodejs"
  echo "vim         ... vim"
  echo "nvim        ... nvim"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help (default)"
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
