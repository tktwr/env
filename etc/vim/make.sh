#!/bin/bash

#======================================================
# functions
#======================================================
f_install_all() {
  cat vimrc_all.vim  > $HOME/.vimrc
  cat vimrc_zero.vim > $HOME/_vimrc
  cat vimrc_zero.vim > $SYS_WIN_HOME/_vimrc
}

f_install_zero() {
  cat vimrc_zero.vim > $HOME/.vimrc
}

f_install_min() {
  cat vimrc_zero.vim > $HOME/.vimrc
}

f_install_min_plug() {
  cat vimrc_zero.vim vimrc_min_plug.vim > $HOME/.vimrc
}

#------------------------------------------------------
f_prof() { vim-log.sh; }

#======================================================
# main
#======================================================
f_fzf_default() { f_install_all; }
f_fzf_main "$@"
