#!/bin/bash

f_set_prompt_none() {
  export PROMPT_DIRTRIM=3
  export PS1="[\w]\$ "
}

f_set_prompt_minimal() {
  export PROMPT_DIRTRIM=3
  export MY_GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  export PS1="$ECOR$ECO2${MY_SHELL_NAME}$ECOD$ECO3[\w](${MY_GIT_BRANCH})$ECOD\$ "
}

