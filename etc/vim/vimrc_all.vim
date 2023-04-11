let $MY_VIM = expand('~/MyRoaming/env/etc/vim')
let $MY_COMMON_SETTING = expand('~/MyConfig/lconfig/common')
let $MY_VIM_PLUGGED_DIR = expand('~/.mycache/vim_plugged')
let $MY_COC_DATA_DIR = expand('~/.mycache/coc_data')

let rc_files  = split(glob('$MY_VIM/vimrc.??.*.vim'), "\n")
let rc_files += split(glob('$MY_COMMON_SETTING/vimrc.??.*.vim'), "\n")

for fname in rc_files
  "echom fname
  exec "source" fname
endfor
