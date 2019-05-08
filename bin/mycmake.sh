#!/bin/sh

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
      ;;
    make*)
      generator_name="Unix Makefiles"
      build_dir=build.$generator/$config
      opt="$opt -DCMAKE_BUILD_TYPE=$config"
      ;;
    vs2017*)
      generator_name="Visual Studio 15 2017 Win64"
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  opt="$opt -DCMAKE_INSTALL_PREFIX=$MY_OPT/usr/local"
  opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"

  echo "cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
  cmake -S. -B$build_dir -G"$generator_name" $opt $@
}

f_mycmake $@

