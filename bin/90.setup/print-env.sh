#!/bin/bash

_f_title() {
  echo "--- [$*] ----------"
}

_f_print_env() {
  printf "%-20s = %s\n" $1 $2
}

_f_print_env_exe() {
  printf "%-20s = %s [%s]\n" $1 $2 $(which $2)
}

#------------------------------------------------------
f_print_env_config() {
  _f_title env_config

  _f_print_env MY_USER_NAME       $MY_USER_NAME
  _f_print_env MY_HOST_NAME       $MY_HOST_NAME
  _f_print_env MY_OS_NAME         $MY_OS_NAME

  _f_print_env SYS_WIN_HOME       $SYS_WIN_HOME
  _f_print_env SYS_LOCAL_HOME     $SYS_LOCAL_HOME
  _f_print_env SYS_ROAMING_HOME   $SYS_ROAMING_HOME
  _f_print_env SYS_CONFIG_HOME    $SYS_CONFIG_HOME
  _f_print_env SYS_WORK_HOME      $SYS_WORK_HOME
  _f_print_env SYS_PROJ_HOME      $SYS_PROJ_HOME
  _f_print_env SYS_DATA_HOME      $SYS_DATA_HOME

  _f_print_env MY_DOTMY           $MY_DOTMY
  _f_print_env MY_PYTHON_VENV_DIR $MY_PYTHON_VENV_DIR
  _f_print_env MY_ENV             $MY_ENV

  _f_print_env MY_REMOTE_CONFIG   $MY_REMOTE_CONFIG
  _f_print_env MY_LOCAL_CONFIG    $MY_LOCAL_CONFIG
  _f_print_env MY_PRIVATE_CONFIG  $MY_PRIVATE_CONFIG
}

f_print_env_exe() {
  _f_title env_exe

  _f_print_env_exe SYS_CAT_EXE   $SYS_CAT_EXE
  _f_print_env_exe SYS_FIND_EXE  $SYS_FIND_EXE
  _f_print_env_exe SYS_FZF_EXE   $SYS_FZF_EXE
  _f_print_env_exe MY_PYTHON_EXE $MY_PYTHON_EXE
}

f_print_env_build() {
  _f_title env_build

  _f_print_env MY_PUSHD_DIR    $MY_PUSHD_DIR
  _f_print_env MY_BUILD_SYS    $MY_BUILD_SYS
  _f_print_env MY_BUILD_CONFIG $MY_BUILD_CONFIG
}

f_print_env_proxy() {
  _f_title env_proxy

  _f_print_env HTTP_PROXY         $HTTP_PROXY
  _f_print_env HTTPS_PROXY        $HTTPS_PROXY
  _f_print_env NO_PROXY           $NO_PROXY
  _f_print_env GIT_SSL_NO_VERIFY  $GIT_SSL_NO_VERIFY
  _f_print_env CURL_SSL_NO_VERIFY $CURL_SSL_NO_VERIFY
  _f_print_env WSL_HOST_IP        $WSL_HOST_IP
  _f_print_env WSL_GUEST_IP       $WSL_GUEST_IP
}

f_check_env_dir() {
  _f_title env_dir

  work_dirs="\
    $MY_REPO \
    $MY_GIT \
    $MY_PROJ \
    $MY_BACKUP \
    $MY_TMP \
    "
  proj_dirs="\
    $MY_DOC \
    $MY_OFFICE \
    "
  data_dirs="\
    $MY_ARCH \
    $MY_SNAP \
    $MY_PAPERS \
    $MY_GITHUB \
    $MY_OPT \
    $MY_MAN \
    $MY_DATA \
    "
  dirs="\
    $MY_PYTHON_VENV_DIR \
    $work_dirs \
    $proj_dirs \
    $data_dirs \
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
  f_print_env_exe
  f_print_env_build
  f_print_env_proxy
  f_check_env_dir
}

f_print_env
