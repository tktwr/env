#!/bin/sh

W=""
if [ -t 1 ]; then
  W="winpty"
fi

f_mycmake_build() {
  local generator=$1
  shift
  local config=$1
  shift

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
    vs2019*)
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  echo "$W /mingw64/bin/cmake --build $build_dir --config $config $opt $@"
  eval "$W /mingw64/bin/cmake --build $build_dir --config $config $opt $@"
}

f_mycmake_build "$@"

