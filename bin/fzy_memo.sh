#!/bin/bash


memo_pre() {
  grep -v '!_TAG_FILE_ENCODING' | awk '{print $1}'
}

memo_post() {
  awk '{print $1}'
}

fzy_memo() {
  local files="\
    $MY_MEMO/tags.memo \
    $MY_SAMPLES/tags.memo \
    $MY_LOCAL_CONFIG/memo/tags.memo \
    $MY_DIARY/tags.memo \
    "
  cmd="cat $files 2> /dev/null"
  echo $(eval $cmd | memo_pre | fzy | memo_post)
}

#------------------------------------------------------
fzy_memo "$@"

