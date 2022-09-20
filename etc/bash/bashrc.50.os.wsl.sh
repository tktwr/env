#!/bin/bash

#======================================================
# wsl
#======================================================
export WSLENV=MY_LIBTT_WIN:MY_OPT_WIN:MY_DATA_WIN

#------------------------------------------------------
# func
#------------------------------------------------------
net-info() {
  net.exe share
  net.exe use
}

wsl_proxy() {
  PROXY_USER=$1
  PROXY_PASS=$2
  #PROXY_HOST=`grep "nameserver" /etc/resolv.conf | cut -d " " -f 2`
  PROXY_HOST=$WSL_HOST_IP
  PROXY_PORT=8888

  export DISPLAY="$PROXY_HOST:0"

  export HTTP_PROXY="http://$PROXY_USER:$PROXY_PASS@$PROXY_HOST:$PROXY_PORT"
  export HTTPS_PROXY="$HTTP_PROXY"
  export http_PROXY="$HTTP_PROXY"
  export https_PROXY="$HTTP_PROXY"
  export FTP_PROXY="$HTTP_PROXY"
  export NO_PROXY="localhost,127.0.0.1"

  export GIT_SSL_NO_VERIFY=1
  export CURL_SSL_NO_VERIFY=1
}

#------------------------------------------------------
# alias
#------------------------------------------------------
alias x='te.sh'
alias gvim='gvim.sh'
alias gvimdiff='gvim.sh -d'
alias gitbash='gitbash.sh'
