#!/bin/bash

_f_git_graph() {
  out=$(git.sh graph "$@")
  echo "$out"
  # if [[ ! "$out" =~ "origin/" ]]; then
  #   git.sh graph origin "$@"
  #   #echo
  # fi
}

_f_git_graph "$@" | $GIT_PAGER
