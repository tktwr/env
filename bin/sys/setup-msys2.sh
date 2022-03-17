#!/bin/bash

#======================================================
# variables
#======================================================
pkg_min="\
winpty \
vim \
bc \
zip unzip \
openssh \
"

pkg_ext="\
make \
rsync \
diffstat \
diffutils \
patch \
patchutils \
man-db \
man-pages-posix \
fzy \
mingw-w64-x86_64-ninja \
mingw-w64-x86_64-universal-ctags-git \
mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz \
mingw-w64-x86_64-qpdf \
mingw-w64-x86_64-ghostscript \
mingw-w64-x86_64-ffmpeg \
"

pkg_dev="\
mingw-w64-x86_64-clang \
mingw-w64-x86_64-clang-tools-extra \
mingw-w64-x86_64-clang-analyzer \
mingw-w64-x86_64-compiler-rt \
mingw-w64-x86_64-glfw \
mingw-w64-x86_64-glew \
mingw-w64-x86_64-freeglut \
mingw-w64-x86_64-glm \
mingw-w64-x86_64-opencv \
mingw-w64-x86_64-openexr \
"

pkg_uninstalled="\
ninja \
tmux \
ctags \
git \
subversion \
vimpager \
global \
python \
vifm \
base-devel \
mingw-w64-x86_64-toolchain \
mingw-w64-x86_64-cmake \
mingw-w64-x86_64-python3-pip \
mingw-w64-x86_64-python2-pip \
mingw-w64-x86_64-gnuplot \
"

#======================================================
# functions
#======================================================
f_update() {
  pacman -Syyu
}

f_install_min() {
  pacman -S --needed $pkg_min
}

f_install_ext() {
  pacman -S --needed $pkg_ext
}

f_install_dev() {
  pacman -S --needed $pkg_dev
}

f_python() {
  mypython-venv-create torch
  pip-upgrade.sh
  pip-install.sh
}

#======================================================
# init
#======================================================
f_default() {
  f_help
}

f_init() {
  f_update
  f_install_min
  #f_install_ext
  #f_install_dev
  #f_python
}

f_help() {
  echo "init        ... init"
  echo "update      ... update"
  echo "install_min ... install_min"
  echo "install_ext ... install_ext"
  echo "install_dev ... install_dev"
  echo "python      ... python"
  echo "help        ... print help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"

