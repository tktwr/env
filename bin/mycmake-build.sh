#!/bin/sh

f_mycmake_build() {
  local generator=$1
  local config=$2

  local build_dir
  local opt

  case $generator in
    ninja*)
      build_dir=build.$generator/$config
      ;;
    make*)
      build_dir=build.$generator/$config
      opt="$opt -j10"
      ;;
    vs2017*)
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  echo "cmake --build $build_dir --config $config $opt"
  cmake --build $build_dir --config $config $opt
}

f_mycmake_build $@

