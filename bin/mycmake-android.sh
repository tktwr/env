#!/bin/sh

SDK=$SYS_WIN_HOME/AppData/Local/Android/sdk
NDK=$SDK/ndk-bundle
CMAKE=$SDK/cmake/3.6.4111459/bin/cmake.exe

CMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake
ANDROID_ABI=arm64-v8a
API_LEVEL=26
ANDROID_PLATFORM=android-$API_LEVEL

config=Release
config=Debug
build_dir=build.android/$config
opt="$opt -DCMAKE_BUILD_TYPE=$config"

mkdir -p $build_dir
cd $build_dir

winpty $CMAKE ../.. -GNinja -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE -DANDROID_ABI=$ANDROID_ABI -DANDROID_PLATFORM=$ANDROID_PLATFORM $opt

winpty $CMAKE --build . --config $config

