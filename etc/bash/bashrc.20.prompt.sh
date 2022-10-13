#!/bin/bash

export PROMPT_DIRTRIM=3

#------------------------------------------------------
# MY_PROMPT_TYPE:
# 0: none   [f_set_prompt_none]
# 1: min    [f_set_prompt_git_branch, gitgutter]
# 2: middle [f_set_prompt_git_fast]
# 3: max    [f_set_prompt_git, fugitive, coc]
# 4: full   [fern-git-status]
case $MY_OS_NAME in
  wsl|linux)
    export MY_PROMPT_TYPE=4
    ;;
  msys|gitbash)
    export MY_PROMPT_TYPE=1
    ;;
esac

#------------------------------------------------------
# prompt color
#------------------------------------------------------
f_get_prompt_color_host() {
  local ECO
  case $MY_HOST_NAME in
    *) ECO=$ECO1 ;;
  esac
  echo $ECO$MY_HOST_NAME
}

f_get_prompt_color_os() {
  local ECO
  case $MY_OS_NAME in
    msys)    ECO=$ECO1 ;;
    wsl)     ECO=$ECO2 ;;
    gitbash) ECO=$ECO4 ;;
    linux)   ECO=$ECO5 ;;
    *)       ECO=$ECO6 ;;
  esac
  echo $ECO$MY_OS_NAME
}

f_get_prompt_color_dir() {
  echo "$ECO3[\w]"
}

f_get_prompt_color_git() {
  echo $ECO6'$(__git_ps1 "(%s)")'
}

f_get_prompt_color_git_branch() {
  echo $ECO6\('$(git rev-parse --abbrev-ref HEAD 2> /dev/null)'\)
}

#------------------------------------------------------
f_set_prompt_none() {
  export PS1="\u@\h[\w]\$ "
}

f_set_prompt_git_branch() {
  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_OS=$(f_get_prompt_color_os)
  local PS1_DIR=$(f_get_prompt_color_dir)
  local PS1_GIT=$(f_get_prompt_color_git_branch)

  export PS1="$ECOD$PS1_HOST:$PS1_OS$ECOD$PS1_DIR$PS1_GIT$ECOD\$ "
}

f_set_prompt_git() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  local PS1_HOST=$(f_get_prompt_color_host)
  local PS1_OS=$(f_get_prompt_color_os)
  local PS1_DIR=$(f_get_prompt_color_dir)
  local PS1_GIT=$(f_get_prompt_color_git)

  export PS1="$ECOD$PS1_HOST:$PS1_OS$ECOD$PS1_DIR$PS1_GIT$ECOD\$ "
}

#------------------------------------------------------
f_set_prompt() {
  if [ $MY_PROMPT_TYPE -ge 3 ]; then
    f_set_prompt_git
  elif [ $MY_PROMPT_TYPE -ge 2 ]; then
    f_set_prompt_git_fast
    alias g.='f_checkgit_force'
  elif [ $MY_PROMPT_TYPE -ge 1 ]; then
    f_set_prompt_git_branch
  else
    f_set_prompt_none
  fi
}
