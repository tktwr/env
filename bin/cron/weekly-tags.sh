#!/bin/bash

cd $MY_ENV
mymake.sh tags

cd $MY_VIM
mymake.sh plug_tags

cd $MY_MEMO
mymake.sh tags_memo

cd $MY_LOCAL_CONFIG/memo
mymake.sh tags_memo

cd $MY_SAMPLES
mymake.sh tags.memo

cd $MY_LIBTT
mymake.sh tags

