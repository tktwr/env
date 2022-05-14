#!/bin/bash

alias x='te.sh'
alias ls='ls.sh'
alias gvim='gvim.sh'
alias gvimdiff='gvim.sh -d'

net-info() {
  net.exe share
  net.exe use
}

f_get_nameserver_ip() {
  grep nameserver /etc/resolv.conf | cut -d " " -f 2
}

f_set_proxy() {
  export HTTP_PROXY="$1"
  export HTTPS_PROXY="$HTTP_PROXY"
  export http_PROXY="$HTTP_PROXY"
  export https_PROXY="$HTTP_PROXY"
  export FTP_PROXY="$HTTP_PROXY"
  export GIT_SSL_NO_VERIFY=1
  export CURL_SSL_NO_VERIFY=1
  export NO_PROXY="localhost,127.0.0.1"
}
