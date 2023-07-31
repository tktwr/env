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

" tags for memo
set tags+=$MY_MEMO/tags
set tags+=$MY_LOCAL_CONFIG/memo/tags
set tags+=$MY_DIARY/tags
set tags+=$MY_SAMPLES/tags

" tags for libtt
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt

" tags for opt
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nfd
set tags+=$MY_OPT/tags.stb
set tags+=$MY_OPT/tags.json11
"------------------------------------------------------

let g:mapleader = ','
let g:maplocalleader = ','

let g:dia_file = "$MY_DIARY/diary.md.html"
let g:todo_file = "$MY_DIARY/todo.md.html"

" height
let g:my_term_winheight_max = 20
let g:my_trans_winheight = 10

" width
let g:my_left_winwidth  = &columns >= (82 * 2 + 30) ? 30 : 20
let g:my_right_winwidth = &columns >= (82 * 2 + 30) ? 30 : 20
let g:my_winwidth_max = float2nr(3.0 / 4.0 * (&columns - g:my_left_winwidth))
