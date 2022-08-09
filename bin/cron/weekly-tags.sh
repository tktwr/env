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
  "
for-dir.sh "mymake.sh tags_memo" ${MEMO_DIRS}

#------------------------------------------------------
# help tags
#------------------------------------------------------
PLUG_DIRS="\
  $MY_VIM \
  "
for-dir.sh "mymake.sh plug_tags" ${PLUG_DIRS}

