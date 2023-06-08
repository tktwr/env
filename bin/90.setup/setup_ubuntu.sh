#!/bin/bash

#======================================================
# variables
#======================================================
pkg_min="\
vim \
fzf \
bat \
tree \
fd-find \
ripgrep \
ncdu \
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
neofetch \
btop \
ncal \
googler \
ghostscript \
x11-apps \
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
f_update() {
  sudo -E apt update
  sudo -E apt upgrade
  sudo -E apt autoremove
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
f_info() {
  echo
}

f_help() {
  echo "info        ... print info"
  echo "----------- ... -----------------------------"
  echo "update      ... update"
  echo "----------- ... -----------------------------"
  echo "install_min ... install min pkg"
  echo "install_ext ... install ext pkg"
  echo "install_dev ... install dev pkg"
  echo "----------- ... -----------------------------"
  echo "help        ... print help"
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
