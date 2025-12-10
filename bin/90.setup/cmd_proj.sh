#!/bin/bash

source cmd_git.sh
source cmd_util.sh

#======================================================
# proj
#======================================================
f_01_status() { f_git_submodule_status; }
f_02_update() { f_git_submodule_update_all; }
f_03_tags()   { f_memo_tags; }
f_04_init()   { f_memo_add_memo_js; }

