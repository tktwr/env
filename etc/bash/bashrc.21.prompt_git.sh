#!/bin/bash

f_get_prompt_color_host() {
  local ECO
  case $MY_HOST_NAME in
    *) ECO=$ECO2 ;;
  esac
  echo $ECO$MY_HOST_NAME
}

f_get_prompt_color_os() {
  local ECO
  case $MY_OS_NAME in
    gitbash) ECO=$ECO1 ;;
    msys)    ECO=$ECO2 ;;
    wsl)     ECO=$ECO7 ;;
    termux)  ECO=$ECO4 ;;
    *)       ECO=$ECO6 ;;
  esac
  echo $ECO$MY_OS_NAME
}

f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  #local PS1_HOST=$(f_get_prompt_color_host)
  #local PS1_OS=$(f_get_prompt_color_os)
  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT=$ECO6'$(__git_ps1 "(%s)")'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_DIR$PS1_GIT$ECOD\$ "
}

