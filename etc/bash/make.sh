#!/bin/bash

#======================================================
# functions
#======================================================
f_install_all() {
  ./zero_hostname.sh > $HOME/.my/hostname.sh
  ./make_env.sh > $HOME/.my/env.sh
  cat bashrc_all.sh > $HOME/.bashrc
}

f_install_zero() {
  cat bashrc_zero.sh > $HOME/.bashrc
}

f_install_min() {
  ./zero_hostname.sh > $HOME/.my/hostname.sh
  cat bashrc_zero.sh bashrc_min.sh > $HOME/.bashrc
}

#======================================================
# main
#======================================================
f_fzf_default() { f_install_all; }
f_fzf_main "$@"
