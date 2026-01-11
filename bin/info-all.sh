#!/bin/bash

f_info_all() {
  cmd.sh f_info_env
  cmd.sh f_info_env_build
  cmd.sh f_info_env_proxy
  cmd.sh f_info_env_exe
  cmd.sh f_info_env_dir
  cmd.sh f_info_ver_os
  cmd.sh f_info_ver_exe
  cmd.sh f_info_path_sys
  cmd.sh f_info_path
  cmd.sh f_info_path_python
  cmd.sh f_info_func
  cmd.sh f_info_alias
}

f_info_all2() {
  echo "[] abc"
  echo "[SUCCESS] abc"
  echo "[OK  ] abc"
  echo "[FAIL] abc"
  echo "[TODO] abc"
  echo "[DONE] abc"
}

f_info_all | coloring.py
