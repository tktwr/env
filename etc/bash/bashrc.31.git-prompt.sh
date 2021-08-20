#!/bin/bash

#======================================================
# git-prompt
#======================================================

f_get_prompt_color_host() {
  local ECO
  case $HOSTNAME in
    *)
      ECO=$ECO6
      ;;
  esac
  echo $ECO$HOSTNAME
}

f_get_prompt_color_shell() {
  local ECO
  case $MY_SHELL_NAME in
    gitbash)
      ECO=$ECO1
      ;;
    MINGW64)
      ECO=$ECO2
      ;;
    MSYS)
      ECO=$ECO3
      ;;
    termux)
      ECO=$ECO4
      ;;
    bash)
      ECO=$ECO5
      ;;
    *)
      ECO=$ECO6
      ;;
  esac
  echo $ECOR$ECO$MY_SHELL_NAME$ECOD
}

#------------------------------------------------------
# git-prompt
#------------------------------------------------------
f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_SHELL=$(f_get_prompt_color_shell)
  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT='`__git_ps1`'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_HOST:$PS1_SHELL$PS1_DIR$PS1_GIT$ECOD\$ "
}

#------------------------------------------------------
# git-prompt-fast
#------------------------------------------------------
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
  PROMPT_COMMAND='echo -ne "\033]0;${MY_SHELL_NAME}\007";f_checkgit'

  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT='`f_git_ps1`'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_DIR$PS1_GIT$ECOD\$ "
}

