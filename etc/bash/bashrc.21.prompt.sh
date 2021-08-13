#!/bin/bash

f_set_prompt_minimal() {
  export PROMPT_DIRTRIM=3
  export MY_GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  export PS1="$ECOR$ECO2${MY_SHELL_NAME}$ECOD$ECO3[\w](${MY_GIT_BRANCH})$ECOD\$ "
}

alias p='f_set_prompt_minimal'
