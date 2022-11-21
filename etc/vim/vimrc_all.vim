let $MY_VIM = expand('$HOME/MyRoaming/env/etc/vim')
let $MY_COMMON_SETTING = expand('$HOME/MyConfig/lconfig/common')

let rc_files  = split(glob('$MY_VIM/vimrc.??.*.vim'), "\n")
let rc_files += split(glob('$MY_COMMON_SETTING/vimrc.??.*.vim'), "\n")

for fname in rc_files
  "echom fname
  exec "source" fname
endfor
