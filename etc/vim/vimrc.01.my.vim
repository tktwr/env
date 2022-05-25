"======================================================
" my
"======================================================
set path+=$QTDIR/include

set makeprg=mymake.sh

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

let g:my_winheight = 10
let g:my_term_winheight_max = 20
let g:my_trans_winheight = 10

let g:my_winwidth_max = 110
let g:my_right_winwidth = 30

" vis
let g:my_term_winheight = 10
let g:my_gstatus_winheight = 10
let g:my_fern_2nd_winheight = 18
let g:my_help_winwidth = 82
let g:my_left_winwidth = 30

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
let g:cpm_files = [
  \ "$MY_BMK/bmk.txt",
  \ "$MY_BMK/cmd.txt",
  \ "$MY_BMK/file.txt",
  \ "$MY_BMK/links.txt",
  \ "$MY_BMK/papers.txt",
  \ "$MY_BMK/ref.txt",
  \ "$MY_BMK/term.txt",
  \ "$MY_COMMON_SETTING/bmk/bmk.txt",
  \ "$MY_COMMON_SETTING/bmk/cmd.txt",
  \ "$MY_COMMON_SETTING/bmk/file.txt",
  \ "$MY_COMMON_SETTING/bmk/links.txt",
  \ "$MY_COMMON_SETTING/bmk/papers.txt",
  \ "$MY_COMMON_SETTING/bmk/ref.txt",
  \ "$MY_COMMON_SETTING/bmk/term.txt",
  \ ]
let g:cpm_titles = {
  \ 'buffer'      : ['buf.bmk.main & buf.bmk.file & buf.cmd.main', 'buf.cmd.sub', 'cmd.coc', 'ref.main', 'local.bmk.file'],
  \ 'buffer:side' : ['bmk.side & bmk.dir', 'bmk.dir.sys & local.bmk.dir'],
  \ 'terminal'    : ['local.bmk.dir & term.cmd.my', 'term.main', 'term.system', 'term.git'],
  \ 'diff'        : ['cmd.diff'],
  \ 'ft:dirdiff'  : ['cmd.dirdiff'],
  \ 'ft:git'      : ['cmd.git'],
  \ 'ft:fugitive' : ['cmd.fugitive'],
  \ 'ft:fern'     : ['bmk.side & bmk.dir', 'cmd.fern', 'bmk.dir.sys & local.bmk.dir'],
  \ 'ft:nerdtree' : ['bmk.side & bmk.dir', 'cmd.nerdtree', 'bmk.dir.sys & local.bmk.dir'],
  \ 'ref'         : ['ref.main', 'ref.keys', 'ref.keys2', 'papers', 'links', 'local.links'],
  \ 'ref.terminal' : ['ref.main'],
  \ }

