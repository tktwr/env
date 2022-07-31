#!/bin/bash

f_get_prompt_color_host() {
  local ECO
  case $HOSTNAME in
    *)
      ECO=$ECO6
      ;;
  esac
  echo $ECO$HOSTNAME
}

f_get_prompt_color_os() {
  local ECO
  case $MY_OS_NAME in
    gitbash)
      ECO=$ECO1
      ;;
    msys)
      ECO=$ECO2
      ;;
    wsl)
      ECO=$ECO3
      ;;
    termux)
      ECO=$ECO4
      ;;
    *)
      ECO=$ECO6
      ;;
  esac
  echo $ECOR$ECO$MY_OS_NAME$ECOD
}

f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_OS=$(f_get_prompt_color_os)
  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT=$ECO6'`__git_ps1`'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_HOST:$PS1_OS$PS1_DIR$PS1_GIT$ECOD\$ "
}

