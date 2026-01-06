#!/bin/bash

source func_git.sh

#------------------------------------------------------
case $1 in
  summary)  f_git_ci_summary  ;;
  info)     f_git_ci_info     ;;
  graph)    f_git_ci_graph    ;;
  status)   f_git_ci_status   ;;
  commit)   f_git_ci_commit   ;;
  fetch)    f_git_ci_fetch    ;;
  pull)     f_git_ci_pull     ;;
  push)     f_git_ci_push     ;;
esac
