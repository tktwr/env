#!/bin/bash

#======================================================
# variables
#======================================================
# ncurses-utils   # tput
# util-linux      # column

termux_pkg="\
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

#======================================================
# functions
#======================================================
f_termux_install() {
  pkg install $termux_pkg
}

