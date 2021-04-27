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
" editor to terminal
"------------------------------------------------------
" send a cmd to a terminal
func MyTermSendCmd(cmd)
  let l:cmd = a:cmd
  if (l:cmd == "")
    let l:cmd = getline('.')
  endif
  wincmd j
  let l:bufnr = winbufnr(0)
	call term_sendkeys(l:bufnr, l:cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func MyTermSendCd(dir)
  let l:dir = MyExpandDir(a:dir)
  wincmd j
  let l:bufnr = winbufnr(0)
  call term_sendkeys(l:bufnr, "cd ".l:dir."\<CR>")
endfunc

func MyTermSendCdN2T()
  let l:dir = getcwd()
  let winnr = MyWinFindTerm()
  if winnr != -1
    let l:bufnr = winbufnr(0)
    call term_sendkeys(l:bufnr, "cd ".l:dir."\<CR>")
  endif
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

func MyNERDTreeT2E(dir)
  exec "NERDTree" a:dir
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=? MyTerm         call MyTerm(<f-args>)
command -nargs=0 MyTermV        call MyTermV()
command -nargs=1 -complete=dir  MyNERDTreeT2E  call MyNERDTreeT2E(<f-args>)

