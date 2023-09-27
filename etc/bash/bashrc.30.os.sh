#!/bin/bash

f_os_wsl() {
  export WSLENV=MY_LIBTT_WIN:MY_OPT_WIN:MY_DATA_WIN

  if [ -z "$WSL_HOST_IP" ]; then
    export WSL_HOST_IP=$(grep nameserver /etc/resolv.conf | cut -d " " -f 2)
  fi

  #export DISPLAY="$WSL_HOST_IP:0"
}

f_os_msys() {
  :
}

f_os_gitbash() {
  :
}

f_os_linux() {
  #export XDG_CONFIG_HOME="~/.config"
  #export XDG_DATA_HOME="~/.local/share"
  #export XDG_CACHE_HOME="~/.cache"
  :
}

f_os_termux() {
  :
}

