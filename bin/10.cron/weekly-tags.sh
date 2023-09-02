#!/bin/bash

#------------------------------------------------------
# ctags
#------------------------------------------------------
TAGS_DIRS="\
  $MY_ENV \
  $MY_LIBTT \
  "
for-dir.sh "mymake.sh f_tags" ${TAGS_DIRS}

#------------------------------------------------------
# memo tags
#------------------------------------------------------
MEMO_DIRS="\
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo \
  $MY_SAMPLES \
  $MY_DIARY \
  "
for-dir.sh "mymake.sh f_tags" ${MEMO_DIRS}

#------------------------------------------------------
# help tags
#------------------------------------------------------
PLUG_DIRS="\
  $MY_VIM_PLUGGED_DIR/vim-winbuf-menu/doc \
  $MY_VIM_PLUGGED_DIR/vim-bmk-menu/doc \
  $MY_VIM_PLUGGED_DIR/vim-ide-style/doc \
  $MY_VIM_PLUGGED_DIR/vim-memo/doc \
  "
for-dir.sh "helptags.sh" ${PLUG_DIRS}
