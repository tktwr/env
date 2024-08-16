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
set tags+=$MY_DOTMY/tags.bmk
set tags+=$MY_MEMO/tags
set tags+=$MY_LOCAL_CONFIG/memo/tags
set tags+=$MY_DIARY/tags
set tags+=$MY_SAMPLES/tags
set tags+=$MY_REMOTE_CONFIG/libtt/tags.libtt

let tags_env    = join(split(glob('$MY_ENV/.tags.*'),   "\n"), ",")
let tags_github = join(split(glob('$MY_GITHUB/tags.*'), "\n"), ",")
execute 'set tags+=' . tags_env
execute 'set tags+=' . tags_github
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
