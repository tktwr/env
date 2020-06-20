#!/bin/bash

#======================================================
# function
#
# NOTE: Don't forget to add ";" at the end of the commands.
#======================================================

f_set_DISPLAY() { export DISPLAY="$*:0.0"; }
f_print_DISPLAY() { echo $DISPLAY; }

f_add_path() { export PATH="$PATH:$*"; }
f_add_ld_path() { export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$*"; }
f_add_man_path() { export MANPATH="$MANPATH:$*"; }
f_add_info_path() { export INFOPATH="$INFOPATH:$*"; }

f_ins_path() { export PATH="$*:$PATH"; }
f_ins_ld_path() { export LD_LIBRARY_PATH="$*:$LD_LIBRARY_PATH"; }
f_ins_man_path() { export MANPATH="$*:$MANPATH"; }
f_ins_info_path() { export INFOPATH="$*:$INFOPATH"; }

f_set_core_off() { ulimit -S -c 0; }
f_set_core_on() { ulimit -S -c unlimited; }

f_set_prompt() {
  PROMPT_COMMAND='echo -ne "\033]0;${USERNAME}@${HOSTNAME}: ${PWD}\007"'
  #PROMPT_COMMAND='echo -ne "\033]0;`dirs`\007"'

  export PROMPT_DIRTRIM=2
  export PS1="$ECOR$ECO2${MY_SHELL_NAME}$ECOD$ECO3[\w]$ECOD\$ "
}

f_set_locale() {
  unset LANG LANGUAGE
  unset LC_ALL LC_COLLATE LC_MESSAGES LC_NUMERIC LC_CTYPE LC_MONETARY LC_TIME
  case $1 in
  C)
    export LANG=C
    ;;
  en)
    export LANG=en_US
    export LANGUAGE=en_US:en
    ;;
  ja.eucjp)
    export LANG=ja_JP.eucJP
    export LANGUAGE=ja_JP.eucJP:ja
    ;;
  ja.utf8)
    export LANG=ja_JP.UTF-8
    export LANGUAGE=ja_JP.UTF-8:ja
    ;;
  none)
    ;;
  esac
}

