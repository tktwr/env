#!/bin/bash

_f_git_graph() {
  local mark=""
  local out=$(git.sh graph --color=never -1 "$@")
  cmd.sh f_git_need_action > /dev/null
  local st=$?
  case $st in
    0) mark="[\\e[32m✔ \\e[0m]" ;; # clean
    1) mark="[\\e[31m✘ \\e[0m]" ;; # need_commit
    2) mark="[\\e[34m \\e[0m]" ;; # need_push
    3) mark="[\\e[35m✘ \\e[0m]" ;; # need_commit need_push
  esac
  if [ $st -gt 0 ]; then
    echo -e "$mark $out"
    git.sh status -s
  fi
}

_f_git_graph "$@" | $GIT_PAGER
