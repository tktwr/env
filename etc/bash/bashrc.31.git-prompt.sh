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

f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  local GIT_BRANCH_FUNC='`__git_ps1`'
  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_SHELL=$(f_get_prompt_color_shell)
  local PS1_GIT=$ECO6${GIT_BRANCH_FUNC}

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

f_set_prompt_git_fast() {
  source "$MY_ENV/etc/git/git-prompt.sh"

  #PROMPT_COMMAND='echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007";f_checkgit'
  PROMPT_COMMAND='echo -ne "\033]0;${MY_SHELL_NAME}\007";f_checkgit'

  local GIT_BRANCH_FUNC='`f_git_ps1`'
  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_SHELL=$ECOR$(f_get_prompt_color_shell)$ECOD
  local PS1_GIT=$ECO6${GIT_BRANCH_FUNC}
  local dir="$ECO3[\w]"

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_HOST:$PS1_SHELL$PS1_GIT\n$dir$ECOD\$ "
}

alias g.='f_checkgit_force'

