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
      export OpenCV_DIR=$MSVC_OpenCV_DIR
      opt="$opt -DOpenCV_DIR=$OpenCV_DIR"
      ;;
    vs2019*)
      generator_name="Visual Studio 16 2019"
      build_dir=build.$generator
      export OpenCV_DIR=$MSVC_OpenCV_DIR
      opt="$opt -DOpenCV_DIR=$OpenCV_DIR"
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  opt="$opt -DCMAKE_INSTALL_PREFIX=$MY_OPT/usr/local"

  echo "winpty cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
  eval "winpty cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
}

f_mycmake "$@"

