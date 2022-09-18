#!/bin/bash

CMAKE=cmake
MY_BUILD_SYS=make
MY_BUILD_CONFIG=Release
BUILDRC=$HOME/.my/buildrc

if [ -f $BUILDRC ]; then
  source $BUILDRC
fi

if [ ! -t 1 ]; then
  # stdout is not opened on a terminal
  WINPTY=""
fi

f_help() {
  echo "mycmake.sh         [BUILD_SYS] [BUILD_CONFIG] [CMAKE_OPTIONS]"
  echo "mycmake.sh --build [BUILD_SYS] [BUILD_CONFIG] [CMAKE_OPTIONS]"
  echo "mycmake.sh --build [BUILD_SYS] [BUILD_CONFIG] [CMAKE_OPTIONS] --target clean"
  echo "mycmake.sh --build [BUILD_SYS] [BUILD_CONFIG] [CMAKE_OPTIONS] --target install"
  echo "mycmake.sh --set    BUILD_SYS   BUILD_CONFIG"
  echo
  echo "OPTIONS:"
  echo "  --help          print help"
  echo "  --build-sys     print build_sys"
  echo "  --build-config  print build_config"
  echo "  --build-dir     print build_dir"
  echo "  --set           set build settings"
  echo
  echo "BUILD_SYS:"
  echo "  make|ninja|vs2017|vs2019|vs2022"
  echo
  echo "BUILD_CONFIG:"
  echo "  Debug|Release|RelWithDebInfo"
  echo
  echo "ENV:"
  echo "  MY_BUILD_SYS=$MY_BUILD_SYS"
  echo "  MY_BUILD_CONFIG=$MY_BUILD_CONFIG"
}

f_set() {
  echo "export MY_BUILD_SYS=$1"
  echo "export MY_BUILD_CONFIG=$2"
  echo
  echo "export CC=clang"
  echo "export CXX=clang++"
  echo "export CLANGD_FLAGS=--compile-commands-dir=build.$1/$2"
}

f_eval() {
  echo "======================================================="
  echo "$@"
  echo "======================================================="
  eval "$@"
}

f_mycmake() {
  local build_sys=${1:-$MY_BUILD_SYS}
  shift
  local build_config=${1:-$MY_BUILD_CONFIG}
  shift

  local generator_name
  local build_dir
  local opt

  case $build_sys in
    make)
      CMAKE=cmake
      generator_name="Unix Makefiles"
      build_dir=build.$build_sys/$build_config
      opt="$opt -DCMAKE_BUILD_TYPE=$build_config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    ninja)
      CMAKE=cmake
      generator_name="Ninja"
      build_dir=build.$build_sys/$build_config
      opt="$opt -DCMAKE_BUILD_TYPE=$build_config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    vs2017)
      CMAKE=cmake.exe
      generator_name="Visual Studio 15 2017 Win64"
      build_dir=build.$build_sys
      ;;
    vs2019)
      CMAKE=cmake.exe
      generator_name="Visual Studio 16 2019"
      build_dir=build.$build_sys
      ;;
    vs2022)
      CMAKE=cmake.exe
      generator_name="Visual Studio 17 2022"
      build_dir=build.$build_sys
      ;;
    *)
      echo "no such build_sys: $build_sys"
      return
      ;;
  esac

  opt="$opt -DCMAKE_INSTALL_PREFIX=$MY_OPT_WIN/usr/local"

  f_eval "$WINPTY $CMAKE -S. -B$build_dir -G\"$generator_name\" $opt $@"
}

f_mycmake_build() {
  local build_sys=${1:-$MY_BUILD_SYS}
  shift
  local build_config=${1:-$MY_BUILD_CONFIG}
  shift

  local build_dir
  local opt

  case $build_sys in
    make)
      CMAKE=cmake
      build_dir=build.$build_sys/$build_config
      opt="$opt -j7"
      ;;
    ninja)
      CMAKE=cmake
      build_dir=build.$build_sys/$build_config
      ;;
    vs2017|vs2019|vs2022)
      CMAKE=cmake.exe
      build_dir=build.$build_sys
      ;;
    *)
      echo "no such build_sys: $build_sys"
      return
      ;;
  esac

  f_eval "$WINPTY $CMAKE --build $build_dir --config $build_config $opt $@"
}

case $1 in
  --help)
    f_help
    ;;
  --set)
    shift
    f_set "$@" > $BUILDRC
    ;;
  --build-sys)
    echo $MY_BUILD_SYS
    ;;
  --build-config)
    echo $MY_BUILD_CONFIG
    ;;
  --build-dir)
    echo build.$MY_BUILD_SYS
    ;;
  --build)
    shift
    f_mycmake_build "$@"
    ;;
  *)
    f_mycmake "$@"
    ;;
esac

