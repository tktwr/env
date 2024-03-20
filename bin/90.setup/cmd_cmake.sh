#!/bin/bash

#======================================================
# variables
#======================================================
BUILDRC=$HOME/.my/buildrc.sh
if [ -f $BUILDRC ]; then
  source $BUILDRC
fi

#======================================================
# functions
#======================================================
f_cmake() {
  $SYS_CMAKE_EXE -S. -B$MY_BUILD_DIR -G"$MY_CMAKE_GENERATOR" $MY_CMAKE_OPT "$@"
}
f_cmake_build() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT "$@"
}
f_cmake_install() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT --target install "$@"
}
f_cmake_clean() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT --target clean "$@"
}
