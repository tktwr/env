"======================================================
" Dia
"======================================================
if exists("loaded_dia")
  finish
endif

let loaded_dia = 1
let s:dia = g:my_dia_file
let s:todo = g:my_todo_file
let s:todo_winwidth = 40
let s:todo_winheight = 10

func s:MyDia(sp, type)
  if a:type == 'd'
    exec a:sp s:dia
  elseif a:type == 't'
    exec a:sp s:todo
  elseif a:type == 'h'
    exec a:sp s:todo
    exec "sp" s:dia
    wincmd j
    exec "resize" s:todo_winheight
    wincmd k
  elseif a:type == 'v'
    exec a:sp s:todo
    exec "vsp" s:dia
    wincmd l
    exec "vertical resize" s:todo_winwidth
    wincmd h
  endif
endfunc

func s:MyDiaFind(tag)
  MyCdHere
  let l:tag = '/\['.a:tag.'\]/'
  echo l:tag
  exec "vimgrep" l:tag "%"
  below cw
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command Dia      call s:MyDia('top sp', 'v')
command DiaFull  call s:MyDia('tabe', 'v')
command DiaFullH call s:MyDia('tabe', 'h')
command -nargs=1 DiaFind  call s:MyDiaFind("<args>")

