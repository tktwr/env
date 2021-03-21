"======================================================
" Bmk
"======================================================
if exists("loaded_bmk")
  finish
endif

let g:bmk_file = "$MY_HOME/.my.common/bmk.txt"

let loaded_bmk = 1
let s:bmk_file = g:bmk_file
let s:bmk = {}
let s:keys = ""

func s:BmkLoad()
  let bmk_file = expand(s:bmk_file)
  if !filereadable(bmk_file)
    return
  endif
  let lines = readfile(bmk_file)
  for line in lines
    let mx='\(\w\+\)\s\+\(\f\+\)'
    let line = matchstr(line, mx)
    let key = substitute(line, mx, '\1', '')
    let fname = substitute(line, mx, '\2', '')
    let s:bmk[key] = fname
    let s:keys = s:keys . key . "\n"
  endfor
endfunc

func s:Bmk(key)
  exec "edit" s:bmk[a:key]
endfunc

func s:BmkKeys(A,L,P)
  return s:keys
endfunc

"------------------------------------------------------
" init
"------------------------------------------------------
call s:BmkLoad()

"------------------------------------------------------
" command
"------------------------------------------------------
command -complete=custom,s:BmkKeys -nargs=1 Bmk  call s:Bmk("<args>")

