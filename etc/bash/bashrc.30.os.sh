#!/bin/bash

net-info() {
  net.exe share
  net.exe use
}

#======================================================
# wsl
#======================================================
wsl_proxy() {
  PROXY_USER=$1
  PROXY_PASS=$2
  PROXY_HOST=$WSL_HOST_IP
  PROXY_PORT=8888

  export DISPLAY="$PROXY_HOST:0"

  export HTTP_PROXY="http://$PROXY_USER:$PROXY_PASS@$PROXY_HOST:$PROXY_PORT"
  export HTTPS_PROXY="$HTTP_PROXY"
  export http_PROXY="$HTTP_PROXY"
  export https_PROXY="$HTTP_PROXY"
  export FTP_PROXY="$HTTP_PROXY"
  export NO_PROXY=".example.com,localhost,127.0.0.1"
  export no_proxy="$NO_PROXY"

  export GIT_SSL_NO_VERIFY=1
  export CURL_SSL_NO_VERIFY=1
}

wsl_settings() {
  export WSLENV=MY_LIBTT_WIN:MY_OPT_WIN:MY_DATA_WIN

  alias x='te.sh'
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'
  alias gitbash='gitbash.sh'
  alias git='git.sh'
}

#======================================================
# msys
#======================================================
msys_settings() {
  export WINPTY=winpty

  #export MSYS_NO_PATHCONV=1
  #export MSYS2_ARG_CONV_EXCL="*"

  PATH="$MY_ENV/bat:$PATH"
  PATH="$SYS_GIT/cmd:$PATH"
  PATH="$JAVA_HOME/bin:$PATH"
  PATH="$NODEJS_HOME:$PATH"
  PATH="$SYS_CMAKE/bin:$PATH"
  PATH="$SYS_VULKAN_SDK/Bin:$PATH"
  PATH="$SYS_CUDA_SDK/bin:$SYS_CUDA_SDK/libnvvp:$PATH"
  PATH="$USER_ROAMING/npm:$PATH"

  #PATH="$SYS_GIT/bin:$PATH"
  #PATH="$SYS_GIT/usr/bin:$PATH"
  #PATH="$SYS_GIT/mingw64/bin:$PATH"

  # clang
  #PATH="$ANDROID_SDK/ndk-bundle/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH"
  # make, python2
  #PATH="$ANDROID_SDK/ndk-bundle/prebuilt/windows-x86_64/bin:$PATH"
  # adb
  #PATH="$ANDROID_SDK/platform-tools:$PATH"

  alias x='te.sh'
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'

  #alias adb='winpty adb'
  alias net='winpty net'
  alias ping='winpty ping'
  alias ipconfig='winpty ipconfig'
  alias tracert='winpty tracert'
  alias wsl='winpty wsl'
}

#======================================================
# linux
#======================================================
linux_settings() {
  #export XDG_CONFIG_HOME="~/.config"
  #export XDG_DATA_HOME="~/.local/share"
  #export XDG_CACHE_HOME="~/.cache"

  #alias x='nautilus'
  #alias p='evince'
  alias x='exo-open --launch FileManager'
  alias p='qpdfview --unique'
  alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
}

#======================================================
case $MY_OS_NAME in
  wsl|msys|linux)
    eval "${MY_OS_NAME}_settings"
    ;;
esac
