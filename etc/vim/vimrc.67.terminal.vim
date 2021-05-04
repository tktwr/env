"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func MyTerm(...)
  if a:0 == 0
    let l:type = 0
  else
    let l:type = a:1
  endif
  if l:type == 0
    exec "below term ++rows=".g:my_term_winheight
    set winfixheight
  elseif l:type == 1
    tabedit
    bot term
    only
  elseif l:type == 2
    tabedit
    bot term
    only
    bot term
  endif
endfunc

func MyTermV()
  vnew
  exec "term ++rows=1"
  wincmd p
  close
  exec "resize".g:my_term_winheight
  set winfixheight
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func Tapi_Exec(_, cmdline)
  exec a:cmdline
endfunc

func Tapi_ExecInPrevWin(_, cmdline)
  wincmd p
  exec a:cmdline
endfunc

func Tapi_ExecInAboveWin(bufnr, cmdline)
  wincmd k
  exec a:cmdline
  let width = winwidth(0)
  let winnr = bufwinnr(a:bufnr)
  exec winnr."wincmd w"
  exec "vertical resize" width
  wincmd p
endfunc

func Tapi_ExecInNewTab(_, cmdline)
  tabedit
  exec a:cmdline
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=? MyTerm         call MyTerm(<f-args>)
command -nargs=0 MyTermV        call MyTermV()

