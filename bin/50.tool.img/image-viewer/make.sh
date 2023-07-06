#!/bin/bash

build_dir=build.pydist

#======================================================
# functions
#======================================================
f_dist() {
  rm -rf $build_dir
  mkdir -p $build_dir
  cd $build_dir

  files=../image-viewer.py
  pyinstaller $files --onefile --noconsole --icon ../app.ico
}

f_install() {
  cd $build_dir
  cp dist/image-viewer.exe $SYS_CONFIG_HOME/opt/bin
}

f_clean() {
  rm -rf $build_dir
  rm -rf __pycache__
}

#------------------------------------------------------
f_help() {
  echo "dist"
  echo "install"
  echo "clean"
  echo "help"
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
