#!/bin/bash

BUILD_DIR=build

f_make() {
	mkdir -p $BUILD_DIR
	./make.00.bashrc.env.sh > $BUILD_DIR/.bashrc.env
	./make.01.bashrc.sh > $BUILD_DIR/.bashrc
}

f_install() {
	cp $BUILD_DIR/.bashrc.env $HOME
	cp $BUILD_DIR/.bashrc $HOME
}

f_make
f_install
