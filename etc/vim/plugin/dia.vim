"======================================================
" Dia
"======================================================
if exists("g:loaded_dia")
  finish
endif
let g:loaded_dia = 1

let s:dia_file = ""
let s:todo_file = ""
let s:todo_winwidth = 40
let s:todo_winheight = 10

if exists("g:dia_file")
  let s:dia_file = g:dia_file
endif
if exists("g:todo_file")
  let s:todo_file = g:todo_file
endif

func s:MyDia(sp, type)
  if a:type == 'd'
    exec a:sp s:dia_file
  elseif a:type == 't'
    exec a:sp s:todo_file
  elseif a:type == 'h'
    exec a:sp s:todo_file
    exec "sp" s:dia_file
    wincmd j
    exec "resize" s:todo_winheight
    wincmd k
  elseif a:type == 'v'
    exec a:sp s:todo_file
    exec "vsp" s:dia_file
    wincmd l
    exec "vertical resize" s:todo_winwidth
    wincmd h
  endif
endfunc

func s:MyDiaFind(tag)
  lcd %:h
  let l:tag = '/\['.a:tag.'\]/'
  echo l:tag
  exec "vimgrep" l:tag "%"
  below cw
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command Dia      call s:MyDia('sp', 'd')
command Todo     call s:MyDia('sp', 't')

command DiaTop   call s:MyDia('top sp', 'v')

command DiaFull  call s:MyDia('tabe', 'v')
command DiaFullH call s:MyDia('tabe', 'h')

command -nargs=1 DiaFind  call s:MyDiaFind("<args>")

