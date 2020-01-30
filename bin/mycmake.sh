#!/bin/sh

MY_BUILD_SYS=ninja
MY_BUILD_CONFIG=Release

BUILDRC=$HOME/.buildrc

if [ -f $BUILDRC ]; then
  source $BUILDRC
fi

W=""
if [ -t 1 ]; then
  W="winpty"
fi

f_help() {
  echo "mycmake.sh [OPTIONS] BUILD CONFIG [CMAKE_OPTIONS]"
  echo
  echo "OPTIONS:"
  echo "  --help"
  echo "  --set"
  echo "  --build"
  echo
  echo "BUILD:"
  echo "  ninja|make|vs2017|vs2019"
  echo
  echo "CONFIG:"
  echo "  Debug|Release|RelWithDebInfo"
  echo
  echo "ENV:"
  echo "  MY_BUILD_SYS=$MY_BUILD_SYS"
  echo "  MY_BUILD_CONFIG=$MY_BUILD_CONFIG"
}

f_set() {
  echo "export MY_BUILD_SYS=$1"
  echo "export MY_BUILD_CONFIG=$2"
}

f_eval() {
  echo "$@"
  eval "$@"
}

f_mycmake() {
  local generator=${1:-$MY_BUILD_SYS}
  shift
  local config=${1:-$MY_BUILD_CONFIG}
  shift

  local generator_name
  local build_dir
  local opt

  case $generator in
    ninja)
      generator_name="Ninja"
      build_dir=build.$generator/$config
      opt="$opt -DCMAKE_BUILD_TYPE=$config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    make)
      generator_name="Unix Makefiles"
      build_dir=build.$generator/$config
      opt="$opt -DCMAKE_BUILD_TYPE=$config"
      opt="$opt -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      ;;
    vs2017)
      generator_name="Visual Studio 15 2017 Win64"
      build_dir=build.$generator
      ;;
    vs2019)
      generator_name="Visual Studio 16 2019"
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  opt="$opt -DCMAKE_INSTALL_PREFIX=$MY_OPT_WIN/usr/local"

  f_eval "$W /mingw64/bin/cmake -S. -B$build_dir -G\"$generator_name\" $opt $@"
}

f_mycmake_build() {
  local generator=${1:-$MY_BUILD_SYS}
  shift
  local config=${1:-$MY_BUILD_CONFIG}
  shift

  local build_dir
  local opt

  case $generator in
    ninja)
      build_dir=build.$generator/$config
      ;;
    make)
      build_dir=build.$generator/$config
      opt="$opt -j10"
      ;;
    vs2017)
      build_dir=build.$generator
      ;;
    vs2019)
      build_dir=build.$generator
      ;;
    *)
      echo "no such generator: $generator"
      return
      ;;
  esac

  f_eval "$W /mingw64/bin/cmake --build $build_dir --config $config $opt $@"
}

case $1 in
  --help)
    f_help
    ;;
  --set)
    shift
    f_set "$@" > $BUILDRC
    ;;
  --build)
    shift
    f_mycmake_build "$@"
    ;;
  *)
    f_mycmake "$@"
    ;;
esac

