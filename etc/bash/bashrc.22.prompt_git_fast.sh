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

f_get_prompt_color_git_fast() {
  echo "$ECO6($GIT_BRANCH)"
}

f_set_prompt_git_fast() {
  PROMPT_COMMAND='echo -ne "\033]0;${MY_OS_NAME}\007";f_checkgit'

  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_OS=$(f_get_prompt_color_os)
  local PS1_DIR=$(f_get_prompt_color_dir)
  local PS1_GIT=$(f_get_prompt_color_git_fast)

  export PS1="$ECOD$PS1_HOST:$PS1_OS$ECOD$PS1_DIR$PS1_GIT$ECOD\$ "
}

