#!/bin/bash

f_proxy() {
  PROXY_USER=$1
  PROXY_PASS=$2
  PROXY_HOST=$WSL_HOST_IP
  PROXY_PORT=8888

  export DISPLAY="$WSL_HOST_IP:0"

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

