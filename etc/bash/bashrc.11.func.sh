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

