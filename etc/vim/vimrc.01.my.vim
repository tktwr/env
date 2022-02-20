"======================================================
" my
"======================================================
set path+=$QTDIR/include

set makeprg=mymake.sh

"------------------------------------------------------
" tags
"------------------------------------------------------
" tags.memo
set tags+=$MY_REMOTE_CONFIG/samples/tags.memo
set tags+=$MY_REMOTE_CONFIG/memo/tags.memo
set tags+=$MY_LOCAL_CONFIG/memo/tags.memo
set tags+=$MY_DIARY/tags.memo

" tags for env
set tags+=$MY_ENV/tags/tags.bin_sh
set tags+=$MY_ENV/tags/tags.bin_py
set tags+=$MY_ENV/tags/tags.bash
set tags+=$MY_ENV/tags/tags.vim

" tags for libtt
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt

" tags for opt
set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nativefiledialog
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.stb
set tags+=$MY_OPT/tags.json11
set tags+=$MY_OPT/tags.win
"------------------------------------------------------

let g:mapleader = ','
let g:maplocalleader = ','

let g:my_winheight = 10
let g:my_term_winheight = 10
let g:my_term_winheight_max = 20
let g:my_trans_winheight = 10
let g:my_gstatus_winheight = 10
let g:my_fern_2nd_winheight = 18

let g:my_winwidth_max = 110
let g:my_help_winwidth = 82
let g:my_left_winwidth = 30
let g:my_right_winwidth = 30

let g:my_dia_file = "$MY_DIARY/diary.md.html"
let g:my_todo_file = "$MY_DIARY/todo.md.html"

let g:my_use_fern = $MY_VIM_USE_FERN

func MyLeftWin()
  if g:my_use_fern
    call MyFernDrawerToggle()
    below split
    exec "resize" g:my_fern_2nd_winheight
  else
    call MyNERDTreeToggle()
  endif
endfunc

" bmk
let g:bmk_winwidth = g:my_left_winwidth
if g:my_use_fern
  let g:bmk_edit_dir_func = "MyFern"
else
  let g:bmk_edit_dir_func = "MyNERDTreeFind"
endif

" wbl
let g:wbl_key = "\<End>"
let g:wbl_max = 10

" cpm
let g:cpm_key = "\<Space>"
let g:cpm_term_key = "\<C-Space>"
let g:cpm_files = [
  \ "$MY_BMK/cmd.txt",
  \ "$MY_BMK/bmk.txt",
  \ "$MY_BMK/links.txt",
  \ "$MY_BMK/papers.txt",
  \ "$MY_COMMON_SETTING/bmk_local.txt",
  \ ]
let g:cpm_titles = {
  \ 'buffer'      : ['bmk.main & cmd.main', 'cmd.sub', 'cmd.coc', 'ref.main', 'local.ref'],
  \ 'buffer:side' : ['side.main & bmk.dir'],
  \ 'terminal'    : ['local.bmk', 'term.main', 'term.system', 'term.git'],
  \ 'ref'         : ['ref.main', 'local.ref', 'ref.keys', 'ref.keys2', 'papers', 'links'],
  \ 'ft:fugitive' : ['cmd.fugitive'],
  \ 'ft:fern'     : ['side.main & bmk.dir', 'local.bmk', 'cmd.fern'],
  \ 'ft:nerdtree' : ['side.main & bmk.dir', 'local.bmk', 'cmd.nerdtree'],
  \ }

