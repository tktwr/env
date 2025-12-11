#!/bin/bash

#======================================================
# variables
#======================================================
apt_pkg_min="\
vim fzf fd-find ripgrep bat \
tree ncdu \
zip unzip \
universal-ctags \
python3-pip \
python3-venv \
git-lfs \
"
apt_pkg_ext="\
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
lhasa \
encfs \
lynx \
elinks \
"
apt_pkg_dev="\
cmake \
clang \
clangd \
clang-format \
libglfw3-dev \
libopencv-dev \
python3-tk \
python3-opencv \
python3-doc \
doxygen \
"
apt_pkg_not_install="\
python3-poetry \
pipx \
blender \
nvidia-cuda-toolkit \
baobab \
nodejs npm \
exa \
eblook \
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
f_apt_install_min() { sudo -E apt install $apt_pkg_min; }
f_apt_install_ext() { sudo -E apt install $apt_pkg_ext; }
f_apt_install_dev() { sudo -E apt install $apt_pkg_dev; }
