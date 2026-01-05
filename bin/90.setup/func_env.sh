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
  $MY_SAMPLES \
  $MY_LIBTT \
  $MY_REMOTE_CONFIG/templates \
  $MY_VIM_PLUGGED_DIR/vim-ide-style \
  $MY_LOCAL_CONFIG/memo \
  $MY_LOCAL_CONFIG/memo_family \
  $MY_DIARY \
  $MY_SECRET \
  "
f_envs_status()      { for-dir.sh "git.sh status -s"                $GIT_DIRS; }
f_envs_commit()      { for-dir.sh "git.sh commit -a -m 'update'"    $GIT_DIRS; }
f_envs_graph()       { for-dir.sh "git-graph.sh -1 2> /dev/null"    $GIT_DIRS; }
f_envs_fetch()       { for-dir.sh "git.sh fetch"                    $GIT_DIRS; }
f_envs_pull()        { for-dir.sh "git.sh pull"                     $GIT_DIRS; }
f_envs_push()        { for-dir.sh "cmd.sh f_git_push_origin"        $GIT_DIRS; }
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
