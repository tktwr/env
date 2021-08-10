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

pkg install $pkg

