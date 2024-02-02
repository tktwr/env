#!/bin/bash

#======================================================
# variables
#======================================================
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

#======================================================
# functions
#======================================================
f_install() {
  pkg install $pkg
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
