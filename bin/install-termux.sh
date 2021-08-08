#!/bin/bash

# ncurses-utils   # tput
# util-linux      # column

pkg="\
git \
vim \
tmux \
ncurses-utils \
util-linux \
iconv \
ctags \
diffutils \
clang \
cmake \
python \
vim-python \
openssh \
"

pkg_lib="\
"

pkg install $pkg $pkg_lib

