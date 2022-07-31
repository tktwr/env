#!/bin/bash

export GIT_BRANCH
export PREV_PWD

f_checkgit() {
  if [ "$PWD" != "$PREV_PWD" ]; then
    GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    PREV_PWD="$PWD"
  fi
}

f_checkgit_force() {
  PREV_PWD=""
  f_checkgit
}

f_git_ps1() {
  echo "($GIT_BRANCH)"
}

f_set_prompt_git_fast() {
  PROMPT_COMMAND='echo -ne "\033]0;${MY_OS_NAME}\007";f_checkgit'

  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT=$ECO6'`f_git_ps1`'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_DIR$PS1_GIT$ECOD\$ "
}

