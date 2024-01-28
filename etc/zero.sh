#!/bin/bash

f_zero_init() {
  mkdir -p $HOME/.my
  mkdir -p $HOME/.mycache
}

f_zero_bash() {
  cd bash
  ./zero_hostname.sh > $HOME/.my/hostname.sh
  cat bashrc_zero.sh > $HOME/.bashrc
  cd ..
}

f_zero_vim() {
  cd vim
  cat vimrc_zero.vim > $HOME/.vimrc
  cd ..
}

f_zero_init
f_zero_bash
f_zero_vim
