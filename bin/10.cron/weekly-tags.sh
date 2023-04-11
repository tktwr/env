#!/bin/bash

#------------------------------------------------------
# ctags
#------------------------------------------------------
TAGS_DIRS="\
  $MY_ENV \
  $MY_LIBTT \
  "
for-dir.sh "mymake.sh tags" ${TAGS_DIRS}

#------------------------------------------------------
# memo tags
#------------------------------------------------------
MEMO_DIRS="\
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_SAMPLES \
  $MY_DIARY \
  "
for-dir.sh "mymake.sh tags_memo" ${MEMO_DIRS}

#------------------------------------------------------
# help tags
#------------------------------------------------------
PLUG_DIRS="\
  $MY_VIM_PLUGGED_DIR/vim-winbuf-menu \
  $MY_VIM_PLUGGED_DIR/vim-bmk-menu \
  $MY_VIM_PLUGGED_DIR/vim-ide-style \
  $MY_VIM_PLUGGED_DIR/vim-memo \
  "
for-dir.sh "mymake.sh tags" ${PLUG_DIRS}

