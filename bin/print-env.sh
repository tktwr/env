#!/bin/bash

f_print_env_config() {
  echo "MY_USER_NAME       = $MY_USER_NAME"
  echo "MY_HOST_NAME       = $MY_HOST_NAME"
  echo "MY_OS_NAME         = $MY_OS_NAME"

  echo "SYS_WIN_HOME       = $SYS_WIN_HOME"
  echo "SYS_LOCAL_HOME     = $SYS_LOCAL_HOME"
  echo "SYS_ROAMING_HOME   = $SYS_ROAMING_HOME"
  echo "SYS_CONFIG_HOME    = $SYS_CONFIG_HOME"
  echo "SYS_SHARE_HOME     = $SYS_SHARE_HOME"

  echo "MY_CONFIG          = $MY_CONFIG"
  echo "MY_REMOTE_CONFIG   = $MY_REMOTE_CONFIG"
  echo "MY_LOCAL_CONFIG    = $MY_LOCAL_CONFIG"
  echo "MY_PRIVATE_CONFIG  = $MY_PRIVATE_CONFIG"
}

f_print_env_python() {
  echo "MY_PYTHON_EXE      = $MY_PYTHON_EXE"
  echo "                   = $(which $MY_PYTHON_EXE)"
  echo "MY_PYTHON_TYPE     = $MY_PYTHON_TYPE"
  echo "MY_PYTHON_VENV     = $MY_PYTHON_VENV"
}

f_print_env_build() {
  echo "MY_PUSHD_DIR       = $MY_PUSHD_DIR"
  echo "MY_BUILD_SYS       = $MY_BUILD_SYS"
  echo "MY_BUILD_CONFIG    = $MY_BUILD_CONFIG"
}

f_print_env_proxy() {
  echo "HTTP_PROXY         = $HTTP_PROXY"
  echo "HTTPS_PROXY        = $HTTPS_PROXY"
  echo "GIT_SSL_NO_VERIFY  = $GIT_SSL_NO_VERIFY"
  echo "CURL_SSL_NO_VERIFY = $CURL_SSL_NO_VERIFY"
}

f_print_env() {
  f_print_env_config
  f_print_env_python
  f_print_env_build
  f_print_env_proxy
}

f_print_env
