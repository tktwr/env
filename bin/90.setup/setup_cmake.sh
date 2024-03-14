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
_f_set() {
  export MY_CMAKE_OPT=""
  export MY_BUILD_OPT=""
  export MY_BUILD_SYS=$1
  export MY_BUILD_CONFIG=$2

  case $MY_BUILD_SYS in
    vs2017|vs2019|vs2022)
      export SYS_CMAKE_EXE=cmake.exe
      export MY_CMAKE_OPT="$MY_CMAKE_OPT -DCMAKE_INSTALL_PREFIX=$MY_OPT_WIN/usr/local"
      export MY_BUILD_DIR=_build.$MY_BUILD_SYS
      ;;
    make|ninja)
      export SYS_CMAKE_EXE=cmake
      export MY_CMAKE_OPT="$MY_CMAKE_OPT -DCMAKE_INSTALL_PREFIX=$MY_OPT/usr/local"
      export MY_CMAKE_OPT="$MY_CMAKE_OPT -DCMAKE_BUILD_TYPE=$MY_BUILD_CONFIG"
      export MY_CMAKE_OPT="$MY_CMAKE_OPT -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
      export MY_BUILD_DIR=_build.$MY_BUILD_SYS/$MY_BUILD_CONFIG
      ;;
  esac

  case $MY_BUILD_SYS in
    make)
      MY_CMAKE_GENERATOR="Unix Makefiles"
      MY_BUILD_OPT="$MY_BUILD_OPT -j7"
      ;;
    ninja)
      MY_CMAKE_GENERATOR="Ninja"
      ;;
    vs2017) MY_CMAKE_GENERATOR="Visual Studio 15 2017 Win64" ;;
    vs2019) MY_CMAKE_GENERATOR="Visual Studio 16 2019" ;;
    vs2022) MY_CMAKE_GENERATOR="Visual Studio 17 2022" ;;
  esac

  echo "export SYS_CMAKE_EXE=$SYS_CMAKE_EXE"
  echo "export MY_CMAKE_GENERATOR=\"$MY_CMAKE_GENERATOR\""
  echo "export MY_CMAKE_OPT=\"$MY_CMAKE_OPT\""
  echo "export MY_BUILD_SYS=$MY_BUILD_SYS"
  echo "export MY_BUILD_CONFIG=$MY_BUILD_CONFIG"
  echo "export MY_BUILD_DIR=$MY_BUILD_DIR"
  echo "export MY_BUILD_OPT=\"$MY_BUILD_OPT\""
  echo
  echo "export CC=clang"
  echo "export CXX=clang++"
  echo "export CLANGD_FLAGS=\"--compile-commands-dir=$MY_BUILD_DIR\""
}

f_cmake_make_release()   { _f_set make   Release        > $BUILDRC; }
f_cmake_make_debug()     { _f_set make   Debug          > $BUILDRC; }
f_cmake_ninja_release()  { _f_set ninja  Release        > $BUILDRC; }
f_cmake_ninja_debug()    { _f_set ninja  Debug          > $BUILDRC; }
f_cmake_vs2017_release() { _f_set vs2017 Release        > $BUILDRC; }
f_cmake_vs2017_debug()   { _f_set vs2017 Debug          > $BUILDRC; }
f_cmake_vs2017_reldeb()  { _f_set vs2017 RelWithDebInfo > $BUILDRC; }
f_cmake_vs2019_release() { _f_set vs2019 Release        > $BUILDRC; }
f_cmake_vs2019_debug()   { _f_set vs2019 Debug          > $BUILDRC; }
f_cmake_vs2019_reldeb()  { _f_set vs2019 RelWithDebInfo > $BUILDRC; }
f_cmake_vs2022_release() { _f_set vs2022 Release        > $BUILDRC; }
f_cmake_vs2022_debug()   { _f_set vs2022 Debug          > $BUILDRC; }
f_cmake_vs2022_reldeb()  { _f_set vs2022 RelWithDebInfo > $BUILDRC; }

f_cmake() {
  $SYS_CMAKE_EXE -S. -B$MY_BUILD_DIR -G\"$MY_CMAKE_GENERATOR\" $MY_CMAKE_OPT $@
}
f_cmake_build() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT $@
}
f_cmake_install() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT --target install $@
}
f_cmake_clean() {
  $SYS_CMAKE_EXE --build $MY_BUILD_DIR --config $MY_BUILD_CONFIG $MY_BUILD_OPT --target clean $@
}
