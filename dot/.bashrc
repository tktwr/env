source $HOME/.funcs

f_time_start bashrc_all

  f_time_start .hostname
  source $HOME/.hostname
  f_time_end .hostname

  f_time_start bashrc
  source $MY_REMOTE_CONFIG/env/etc/bash/bashrc
  f_time_end bashrc

  f_time_start bashrc_local
  source $MY_LOCAL_CONFIG/env/etc/bash/bashrc
  f_time_end bashrc_local

f_time_end bashrc_all

