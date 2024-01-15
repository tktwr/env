#!/bin/bash

f_set_proxy() {
  PROXY_HOST=$1
  PROXY_PORT=$2

  export HTTP_PROXY="http://$PROXY_USER:$PROXY_PASS@$PROXY_HOST:$PROXY_PORT"
  export HTTPS_PROXY="$HTTP_PROXY"
  export http_proxy="$HTTP_PROXY"
  export https_proxy="$HTTP_PROXY"
  export FTP_PROXY="$HTTP_PROXY"
  export NO_PROXY=".example.com,localhost,127.0.0.1"
  export no_proxy="$NO_PROXY"

  #export GIT_SSL_NO_VERIFY=1
  #export CURL_SSL_NO_VERIFY=1

  export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
  export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
}

