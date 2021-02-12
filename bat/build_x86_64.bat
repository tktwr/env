@echo off
rem cd %~dp0
rem rmdir /s /q build_x86_64
if not exist build_x86_64 (
  mkdir build_x86_64
)
cd build_x86_64

set ANDROID_NDK=%ANDROID_SDK%\ndk-bundle
set CMAKE_TOOLCHAIN=%ANDROID_NDK%\build\cmake\android.toolchain.cmake

set CMAKE_ROOT_ANDROID_STUDIO=%ANDROID_SDK%\cmake\3.6.4111459

set CMAKE=%CMAKE_ROOT_ANDROID_STUDIO%\bin\cmake.exe
set NINJA=%CMAKE_ROOT_ANDROID_STUDIO%\bin\ninja.exe

%CMAKE% -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN% -DCMAKE_MAKE_PROGRAM=%NINJA% -DANDROID_NDK=%ANDROID_NDK% -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI="x86_64" -GNinja ..

%CMAKE% --build .
rem cd %~dp0
pause
