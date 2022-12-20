#!/bin/bash

#======================================================
# function
#
# NOTE: Don't forget to add ";" at the end of the commands.
#======================================================
f_set_DISPLAY() { export DISPLAY="$*:0.0"; }
f_get_DISPLAY() { echo $DISPLAY; }

f_set_core_off() { ulimit -S -c 0; }
f_set_core_on()  { ulimit -S -c unlimited; }

