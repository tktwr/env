#!/bin/bash

#======================================================
# functions
#======================================================
f_install_all() {
  ./make_env.sh > $HOME/.my/env.sh
  cat bashrc_all.sh > $HOME/.bashrc
}

f_install_zero() {
  cat bashrc_zero_func.sh bashrc_zero.sh > $HOME/.bashrc
}

#======================================================
# main
#======================================================
f_fzf_default() { f_install_all; }
f_fzf_main "$@"
