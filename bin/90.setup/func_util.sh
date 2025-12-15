#!/bin/bash

f_github_tags() {
  local C_TAGS_DIRS="\
    $MY_GITHUB \
    "
  for-dir.sh "mymake.sh f_tags" $C_TAGS_DIRS
}

f_blender_clean() {
  rm $APP_L/Temp/*_autosave.blend
}
