#!/bin/sh

W=""
if [ -t 1 ]; then
  W="winpty"
fi

f_mycmake() {
  local generator=$1
  shift
  local config=$1
  shift

  local generator_name
  local build_dir
  local opt

  case $generator in
    ninja*)
      generator_name="Ninja"
      build_dir=build.$generator/$config
      opt="$opt -DCMAKE_BUILD_TYPE=$config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    make*)
      generator_name="Unix Makefiles"
      build_dir=build.$generator/$config
      opt="$opt -DCMAKE_BUILD_TYPE=$config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    vs2017*)
      generator_name="Visual Studio 15 2017 Win64"
      build_dir=build.$generator
      ;;
    vs2019*)
      generator_name="Visual Studio 16 2019"
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  opt="$opt -DCMAKE_INSTALL_PREFIX=$MY_OPT_WIN/usr/local"

  echo "$W /mingw64/bin/cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
  eval "$W /mingw64/bin/cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
}

f_mycmake "$@"

