#!/bin/bash

#======================================================
# git-prompt
#======================================================

f_get_prompt_color_host() {
  local CO
  case $HOSTNAME in
    *)
      CO=$ECO6
      ;;
  esac
  echo $CO$HOSTNAME
}

f_get_prompt_color_shell() {
  local CO
  case $MY_SHELL_NAME in
    gitbash)
      CO=$ECO1
      ;;
    MINGW64)
      CO=$ECO2
      ;;
    MSYS)
      CO=$ECO3
      ;;
    termux)
      CO=$ECO4
      ;;
    bash)
      CO=$ECO5
      ;;
    *)
      CO=$ECO6
      ;;
  esac
  echo $CO$MY_SHELL_NAME
}

f_set_git_prompt() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  GIT_BRANCH_FUNC='`__git_ps1`'
  PS1_HOST=$(f_get_prompt_color_host)
  PS1_SHELL=$(f_get_prompt_color_shell)
  PS1_GIT=$ECO6${GIT_BRANCH_FUNC}

  export PROMPT_DIRTRIM=2
  export PS1="$PS1_HOST:$ECOR$PS1_SHELL$ECOD$ECO3[\w]$PS1_GIT$ECOD\$ "
}

#------------------------------------------------------
# git-prompt-fast
#------------------------------------------------------

export GIT_BRANCH
export PREV_PWD

f_checkgit() {
  if [ "$PWD" != "$PREV_PWD" ]; then
    GIT_BRANCH=`__git_ps1`
    PREV_PWD="$PWD"
  fi
}

f_checkgit_force() {
  PREV_PWD=""
  f_checkgit
}

f_git_ps1() {
  echo "[$MY_PYTHON_TYPE,$MY_PYTHON_VENV][$MY_BUILD_SYS,$MY_BUILD_CONFIG]$GIT_BRANCH"
}

f_set_git_prompt_fast() {
  source "$MY_ENV/etc/git/git-prompt.sh"

  PROMPT_COMMAND='echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007";f_checkgit'
  GIT_BRANCH_FUNC='`f_git_ps1`'
  PS1_HOST=$(f_get_prompt_color_host)
  PS1_SHELL=$(f_get_prompt_color_shell)
  PS1_GIT=$ECO6${GIT_BRANCH_FUNC}

  export PROMPT_DIRTRIM=3
  local dir="$ECO3[\w]$ECOD"
  export PS1="$PS1_HOST:$ECOR$PS1_SHELL$ECOD$PS1_GIT$ECOD\n$dir\$ "
}

alias g.='f_checkgit_force'

