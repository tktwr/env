#!/bin/bash

f_envs_tags() {
  local VIM_FILES="\
    $MY_ENV/etc/vim/*.vim \
    $MY_ENV/etc/vim/vim-plug/*.vim \
    $MY_ENV/etc/vim/plugin \
    $MY_VIM_PLUGGED_DIR/vim-ide-style \
    "
  cd $MY_ENV
  ctags -o .tags.bin_sh -R bin/*.sh bin/*/*.sh
  ctags -o .tags.bin_py -R bin/py/*.py
  ctags -o .tags.bash   -R etc/bash/*.sh
  ctags -o .tags.vim    -R $VIM_FILES

  local MEMO_TAGS_DIRS="\
    $MY_MEMO \
    $MY_LOCAL_CONFIG/memo \
    $MY_DIARY \
    "
  for-dir.sh "mymake.sh f_memo_tags" $MEMO_TAGS_DIRS

  local C_TAGS_DIRS="\
    $MY_LIBTT \
    $MY_SAMPLES \
    "
  for-dir.sh "mymake.sh f_tags" $C_TAGS_DIRS

  local PLUG_DIRS="\
    $MY_VIM_PLUGGED_DIR/vim-ide-style/doc \
    "
  for-dir.sh "helptags.sh" $PLUG_DIRS
}
#------------------------------------------------------
GIT_DIRS="\
  $MY_ENV \
  $MY_MEMO \
  $MY_LOCAL_CONFIG/memo_private \
  $MY_LOCAL_CONFIG/memo_family \
  $MY_DIARY \
  $MY_SECRET \
  "
GIT_ALL_DIRS="\
  $MY_LOCAL_CONFIG/memo \
  $MY_SAMPLES \
  $MY_LIBTT \
  $MY_REMOTE_CONFIG/templates \
  $MY_VIM_PLUGGED_DIR/vim-ide-style \
  "
f_envs_ci_fetch_summary() { for-dir.sh "cmd.sh f_git_ci_fetch_summary" $GIT_DIRS; }
f_envs_ci_summary()       { for-dir.sh "cmd.sh f_git_ci_summary"       $GIT_DIRS; }
f_envs_ci_info()          { for-dir.sh "cmd.sh f_git_ci_info"          $GIT_DIRS; }
f_envs_ci_graph()         { for-dir.sh "cmd.sh f_git_ci_graph"         $GIT_DIRS; }
f_envs_ci_status()        { for-dir.sh "cmd.sh f_git_ci_status"        $GIT_DIRS; }
f_envs_ci_commit()        { for-dir.sh "cmd.sh f_git_ci_commit"        $GIT_DIRS; }
f_envs_ci_fetch()         { for-dir.sh "cmd.sh f_git_ci_fetch"         $GIT_DIRS; }
f_envs_ci_pull()          { for-dir.sh "cmd.sh f_git_ci_pull"          $GIT_DIRS; }
f_envs_ci_push()          { for-dir.sh "cmd.sh f_git_ci_push"          $GIT_DIRS; }
f_envs_ci_vimdiff()       { for-dir.sh "cmd.sh f_git_ci_vimdiff"       $GIT_DIRS; }
#------------------------------------------------------
BUILD_DIRS="\
  $MY_LIBTT \
  $MY_SAMPLES/cpp \
  $MY_SAMPLES/cpp_lib \
  "
f_envs_build()       { for-dir.sh "make all"            $BUILD_DIRS; }
f_envs_build_clean() { for-dir.sh "make all.clean"      $BUILD_DIRS; }
#------------------------------------------------------
# build
#------------------------------------------------------
f_envs_tools() {
  cd $MY_BIN/50.tool.img/image-viewer
  mymake.sh f_dist
  mymake.sh f_install
}
