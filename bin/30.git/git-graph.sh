#!/bin/bash

_f_git_graph() {
  out=$(git.sh graph "$@")
  if [[ ! "$out" =~ "origin/" ]]; then
    git.sh graph origin "$@"
    echo
  fi
  echo "$out"
}

_f_git_graph "$@" | $GIT_PAGER
