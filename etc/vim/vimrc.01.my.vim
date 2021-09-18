"======================================================
" my
"======================================================
set path+=$QTDIR/include

set tags+=$MY_ENV/tags.bin.sh
set tags+=$MY_ENV/tags.bin.py
set tags+=$MY_ENV/tags.etc.sh
set tags+=$MY_ENV/tags.etc.vim
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt
set tags+=$MY_REMOTE_CONFIG/samples/tags.memo
set tags+=$MY_REMOTE_CONFIG/memo/tags.memo
set tags+=$MY_LOCAL_CONFIG/memo/tags.memo
set tags+=$MY_OPT/tags.eigen
set tags+=$MY_OPT/tags.glm
set tags+=$MY_OPT/tags.imgui
set tags+=$MY_OPT/tags.nativefiledialog
set tags+=$MY_OPT/tags.opencv2
set tags+=$MY_OPT/tags.stb
set tags+=$MY_OPT/tags.json11
set tags+=$MY_OPT/tags.win

let g:mapleader = ','
let g:maplocalleader = ','

let g:my_winheight = 10
let g:my_term_winheight = 10
let g:my_term_winheight_max = 20
let g:my_trans_winheight = 10
let g:my_gstatus_winheight = 10

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
  \ 'terminal': ['terminal:main', 'terminal:system', 'terminal:git', 'bmk:dir', 'bmk:local'],
  \ 'fern': ['buffer:fern', 'bmk:dir', 'bmk:local'],
  \ 'nerdtree': ['buffer:nerdtree', 'bmk:dir', 'bmk:local'],
  \ 'buffer': ['buffer:main', 'buffer:sub', 'buffer:coc', 'ref:main', 'ref:local'],
  \ }

