#!/bin/bash

f_print_env_config() {
  echo "MY_USER_NAME       = $MY_USER_NAME"
  echo "MY_HOST_NAME       = $MY_HOST_NAME"
  echo "MY_OS_NAME         = $MY_OS_NAME"

  echo "SYS_WIN_HOME       = $SYS_WIN_HOME"
  echo "SYS_LOCAL_HOME     = $SYS_LOCAL_HOME"
  echo "SYS_ROAMING_HOME   = $SYS_ROAMING_HOME"
  echo "SYS_CONFIG_HOME    = $SYS_CONFIG_HOME"
  echo "SYS_WORK_HOME      = $SYS_WORK_HOME"
  echo "SYS_PROJ_HOME      = $SYS_PROJ_HOME"
  echo "SYS_DATA_HOME      = $SYS_DATA_HOME"

  echo "MY_DOTMY           = $MY_DOTMY"
  echo "MY_PYTHON_VENV_DIR = $MY_PYTHON_VENV_DIR"
  echo "MY_ENV             = $MY_ENV"

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
  echo "NO_PROXY           = $NO_PROXY"
  echo "GIT_SSL_NO_VERIFY  = $GIT_SSL_NO_VERIFY"
  echo "CURL_SSL_NO_VERIFY = $CURL_SSL_NO_VERIFY"
  echo "WSL_HOST_IP        = $WSL_HOST_IP"
  echo "WSL_GUEST_IP       = $WSL_GUEST_IP"
}

f_check_env_dir() {
  private_dirs="\
    $MY_PROJ \
    $MY_WORK \
    $MY_GIT \
    $MY_DOC \
    $MY_OFFICE \
    $MY_BACKUP \
    $MY_TMP \
    $MY_REPO \
    $MY_SNAP \
    "
  public_dirs="\
    $MY_ARCH \
    $MY_PAPERS \
    $MY_GITHUB \
    $MY_OPT \
    $MY_MAN \
    $MY_DATA \
    "
  dirs="\
    $MY_PYTHON_VENV_DIR \
    $private_dirs \
    $public_dirs \
    "
  for i in $dirs; do
    if [ -d "$i" ]; then
      echo "[OK  ] $i"
    else
      echo "[FAIL] $i"
    fi
  done
}

f_print_env() {
  f_print_env_config
  f_print_env_python
  f_print_env_build
  f_print_env_proxy
  f_check_env_dir
}

f_print_env
