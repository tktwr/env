#!/bin/bash

source func_git.sh

_f_git_status() {
  git.sh status -s
}

_f_git_commit() {
  f_git_need_commit; local need_commit=$?
  if [ $need_commit -eq 1 ]; then
    git.sh commit -a -m 'update'
  fi
}

_f_git_graph() {
  f_git_need_action > /dev/null; local need_action=$?
  local mark=""
  case $need_action in
    0) mark="[\\e[32m✔ \\e[0m]" ;; # clean
    1) mark="[\\e[31m✘ \\e[0m]" ;; # need_commit
    2) mark="[\\e[34m \\e[0m]" ;; # need_push
    3) mark="[\\e[35m✘ \\e[0m]" ;; # need_commit need_push
  esac
  if [ $need_action -gt 0 ]; then
    local out=$(git.sh graph --color=never -1)
    echo -e "$mark $out"
    git.sh status -s
  fi
}

_f_git_fetch() {
  git.sh fetch
}

_f_git_pull() {
  git.sh pull
}

_f_git_push() {
  f_git_push_origin
}

case $1 in
  status) _f_git_status ;;
  commit) _f_git_commit ;;
  graph)  _f_git_graph  ;;
  fetch)  _f_git_fetch  ;;
  pull)   _f_git_pull   ;;
  push)   _f_git_push   ;;
esac
