"------------------------------------------------------
" Dia
"------------------------------------------------------
if exists("loaded_dia")
  finish
endif

let loaded_dia = 1
let s:dia = g:my_dia_file
let s:todo = g:my_todo_file

func s:MyDia(sp, type)
  if a:type == 'd'
    exec a:sp s:dia
  elseif a:type == 't'
    exec a:sp s:todo
  elseif a:type == 'h'
    exec a:sp s:todo
    exec "sp" s:dia
    wincmd j
    resize 10
    wincmd k
  elseif a:type == 'v'
    exec a:sp s:todo
    exec "vsp" s:dia
    wincmd l
    vertical resize 40
    wincmd h
  endif
endfunc

func s:MyDiaFindTodo()
  MyCdHere
  vimgrep '\[TODO\]' %
  below cw
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command Dia      call s:MyDia('top sp', 'v')
command DiaFull  call s:MyDia('tabe', 'v')
command DiaFullH call s:MyDia('tabe', 'h')
command DiaTodo  call s:MyDiaFindTodo()

