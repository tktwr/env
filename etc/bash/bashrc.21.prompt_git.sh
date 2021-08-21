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

f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_SHELL=$(f_get_prompt_color_shell)
  local PS1_DIR="$ECO3[\w]"
  local PS1_GIT=$ECO6'`__git_ps1`'

  export PROMPT_DIRTRIM=3
  export PS1="$PS1_HOST:$PS1_SHELL$PS1_DIR$PS1_GIT$ECOD\$ "
}

