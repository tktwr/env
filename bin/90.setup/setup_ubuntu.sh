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
poppler-utils \
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
f_apt_update() {
  sudo -E apt update
  sudo -E apt upgrade
  sudo -E apt autoremove
}

#------------------------------------------------------
f_apt_install_min() {
  sudo -E apt install $pkg_min
}

f_apt_install_ext() {
  sudo -E apt install $pkg_ext
}

f_apt_install_dev() {
  sudo -E apt install $pkg_dev
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
