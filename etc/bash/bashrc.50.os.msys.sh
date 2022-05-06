#!/bin/bash

#======================================================
# windows
#======================================================

#export MSYS_NO_PATHCONV=1
#export MSYS2_ARG_CONV_EXCL="*"

PATH="$MY_ENV/bat:$PATH"
PATH="$SYS_GIT/cmd:$PATH"
PATH="$JAVA_HOME/bin:$PATH"
PATH="$NODEJS_HOME:$PATH"
PATH="$SYS_CMAKE/bin:$PATH"
PATH="$SYS_VULKAN_SDK/Bin:$PATH"
PATH="$SYS_CUDA_SDK/bin:$SYS_CUDA_SDK/libnvvp:$PATH"

#PATH="$SYS_GIT/bin:$PATH"
#PATH="$SYS_GIT/usr/bin:$PATH"
#PATH="$SYS_GIT/mingw64/bin:$PATH"

# clang
#PATH="$ANDROID_SDK/ndk-bundle/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH"
# make, python2
#PATH="$ANDROID_SDK/ndk-bundle/prebuilt/windows-x86_64/bin:$PATH"
# adb
#PATH="$ANDROID_SDK/platform-tools:$PATH"

#------------------------------------------------------
# alias
#------------------------------------------------------

alias x='te.sh'
alias ls='ls.sh'
alias gvim='gvim.sh'
alias gvimdiff='gvim.sh -d'

#alias adb='winpty adb'
alias net='winpty net'
alias ping='winpty ping'
alias ipconfig='winpty ipconfig'
alias tracert='winpty tracert'

net-info() {
  net.exe share
  net.exe use
}

