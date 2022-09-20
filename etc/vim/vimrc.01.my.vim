"======================================================
" my
"======================================================
set path+=$QTDIR/include

set makeprg=mymake.sh

if executable('rg')
  let &grepprg = 'rg --vimgrep'
  set grepformat=%f:%l:%c:%m
endif

"------------------------------------------------------
" tags
"------------------------------------------------------
" tags for env
set tags+=$MY_ENV/.tags.bin_sh
set tags+=$MY_ENV/.tags.bin_py
set tags+=$MY_ENV/.tags.bash
set tags+=$MY_ENV/.tags.vim

" tags for libtt
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt

" tags for opt
"set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nativefiledialog
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.stb
set tags+=$MY_OPT/tags.json11
"set tags+=$MY_OPT/tags.win
"------------------------------------------------------

let g:mapleader = ','
let g:maplocalleader = ','

let g:dia_file = "$MY_DIARY/diary.md.html"
let g:todo_file = "$MY_DIARY/todo.md.html"

" height
let g:my_winheight = 10
let g:my_term_winheight = 10
let g:my_term_winheight_max = 20
let g:my_fern_2nd_winheight = 18
let g:my_gstatus_winheight = 10
let g:my_trans_winheight = 10

" width
let g:my_winwidth_max = 110
let g:my_help_winwidth = 82
let g:my_left_winwidth = 30
let g:my_right_winwidth = 30

" wbl
let g:wbl_key = "\<End>"
let g:wbl_max = 10

" bmk
let g:bmk_winwidth = g:my_left_winwidth
let g:bmk_edit_dir_func = "VisFern"
let g:bmk_open_url_prog = "chrome.sh"
let g:bmk_open_dir_prog = "te.sh"
let g:bmk_open_file_prog = "vscode.sh"

" cpm
let g:cpm_key = "\<Space>"
let g:cpm_term_key = "\<C-Space>"
let g:cpm_user_bmk_dir = '$MY_DOTMY/bmk/bmk_dir.txt'
let g:cpm_user_bmk_file = '$MY_DOTMY/bmk/bmk_file.txt'
let g:cpm_files = 
  \ split(glob("$MY_BMK/*.txt")) +
  \ split(glob("$MY_COMMON_SETTING/bmk/*.txt"))
let g:cpm_titles = {
  \ 'default'          : ['vcmd.menu & vcmd.external & bmk.file & vcmd.ide', 'vcmd.sub', 'local.bmk.file'],
  \ 'default.fern'     : ['fern.menu & fern.external & bmk.dir', 'bmk.dir.sys & local.bmk.dir'],
  \ 'default.terminal' : ['tcmd.menu & tcmd.main & local.bmk.dir', 'tcmd.sub'],
  \ 'default.diff'     : ['vcmd.diff'],
  \ 'default.dirdiff'  : ['vcmd.dirdiff'],
  \ 'default.git'      : ['vcmd.git'],
  \ 'default.fugitive' : ['vcmd.fugitive'],
  \ 'ref'              : ['ref.main', 'ref.keys', 'ref.keys2', 'papers', 'links', 'local.links'],
  \ 'ref.terminal'     : ['ref.main'],
  \ 'fzy'              : ['fzy'],
  \ 'fzy.fern'         : ['fzy.fern'],
  \ 'fzy.terminal'     : ['fzy.terminal'],
  \ 'coc'              : ['coc'],
  \ 'fern'             : ['fern'],
  \ 'tcmd.git'         : ['tcmd.git'],
  \ 'tcmd.system'      : ['tcmd.system'],
  \ }

