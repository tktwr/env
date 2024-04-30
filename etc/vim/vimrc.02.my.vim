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
" bmk
set tags+=$MY_DOTMY/tags.bmk
set tags+=$MY_GITHUB/tags.bmk

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
set tags+=$MY_GITHUB/tags.opencv2
set tags+=$MY_GITHUB/tags.eigen
set tags+=$MY_GITHUB/tags.glm
set tags+=$MY_GITHUB/tags.imgui
set tags+=$MY_GITHUB/tags.nfd
set tags+=$MY_GITHUB/tags.stb
set tags+=$MY_GITHUB/tags.json11
"------------------------------------------------------

let g:mapleader = ','
let g:maplocalleader = ','

let g:dia_file = "$MY_DIARY/diary.md.html"
let g:todo_file = "$MY_DIARY/todo.md.html"

" height
let g:my_trans_winheight = My_default_term_height()

" width
let g:my_left_winwidth  = My_default_side_width()
let g:my_right_winwidth = My_default_side_width()
