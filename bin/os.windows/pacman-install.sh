#!/bin/bash

INSTALL=(\
winpty \
vim \
tmux \
ctags \
fzy \
zip \
unzip \
bc \
man-pages-posix \
base-devel \
mingw-w64-x86_64-toolchain \
mingw-w64-x86_64-clang \
mingw-w64-x86_64-universal-ctags-git \
mingw-w64-x86_64-ghostscript \
mingw-w64-x86_64-imagemagick \
mingw-w64-x86_64-graphviz \
mingw-w64-x86_64-glfw \
mingw-w64-x86_64-glew \
mingw-w64-x86_64-freeglut \
mingw-w64-x86_64-glm \
mingw-w64-x86_64-opencv \
)

NOT_INSTALL=(\
git \
subversion \
vifm \
vimpager \
global \
python \
mingw-w64-x86_64-cmake \
mingw-w64-x86_64-gnuplot \
mingw-w64-x86_64-qpdf \
)

f_install() {
  pacman -S --needed "$@"
}

f_echo() {
  echo "$@"
}

f_install ${INSTALL[@]}
#f_echo ${NOT_INSTALL[@]}

