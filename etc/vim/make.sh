#!/bin/bash

source $HOME/.my/hostname
source $HOME/.bashrc.env

BUILD_DIR=build

f_make() {
  mkdir -p $BUILD_DIR
  ./make.00.vimrc.env.sh unix $MY_SHELL_NAME > $BUILD_DIR/.vimrc.env
  ./make.01.vimrc.sh > $BUILD_DIR/.vimrc
}

f_install() {
	cp $BUILD_DIR/.vimrc.env $HOME
	cp $BUILD_DIR/.vimrc $HOME
}

f_make
f_install
