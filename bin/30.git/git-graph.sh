#!/bin/bash

f_git_graph() {
  out=$(git.sh graph "$@")
  if [[ ! "$out" =~ "origin/" ]]; then
    git.sh graph origin "$@"
  fi
  echo "$out"
}

f_git_graph "$@"
