let $MY_VIM = expand('$HOME/MyRoaming/env/etc/vim')
let $MY_COMMON_SETTING = expand('$HOME/MyConfig/lconfig/common')

let rc_files  = glob('$MY_VIM/vimrc.??.*.vim')
let rc_files1 = glob('$MY_COMMON_SETTING/vimrc.??.*.vim')
if !empty(rc_files1)
  let rc_files += rc_files1
endif
let rc_files = split(rc_files, "\n")
for fname in rc_files
  "echom fname
  exec "source" fname
endfor
