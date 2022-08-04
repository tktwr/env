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

#------------------------------------------------------
f_help() {
  echo "install ... install"
  echo "help    ... print help"
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

