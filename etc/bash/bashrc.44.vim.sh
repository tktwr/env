#!/bin/bash

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
my_setup_vim() {
  source_file $MY_VIM_PLUGGED_DIR/vim-ide-style/etc/bashrc
  source_file $MY_VIM_PLUGGED_DIR/vim-ide-style/etc/bashrc.alias
  source_file $MY_VIM_PLUGGED_DIR/vim-memo/etc/bashrc

  if [ "$VIM_TERMINAL" ]; then
    vimapi-tabline-set-info "[ :$MY_BUILD_SYS,$MY_BUILD_CONFIG]"
    vimapi-term-set-label "$MY_USER_NAME@$MY_HOST_NAME [$MY_OS_NAME]"
  fi
}
