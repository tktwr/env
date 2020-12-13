#!/bin/bash

MY_OS=unix
MY_SHELL=MINGW64

BUILD_DIR=build

f_make() {
  mkdir -p $BUILD_DIR
  ./make.00.vimrc.env.sh $MY_OS $MY_SHELL > $BUILD_DIR/.vimrc.env
  ./make.01.vimrc.sh > $BUILD_DIR/.vimrc
}

f_install() {
	cp $BUILD_DIR/.vimrc.env $HOME
	cp $BUILD_DIR/.vimrc $HOME
}

f_make
f_install
