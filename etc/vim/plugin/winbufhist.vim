"======================================================
" WinBufHist
"======================================================
if exists("g:loaded_winbufhist")
  finish
endif
let g:loaded_winbufhist = 1

let s:max_buflist = 10

"------------------------------------------------------
" private func
"------------------------------------------------------
func s:Print()
  for i in w:buflist
    echo "-" i bufname(i)
  endfor
endfunc

func s:Clear()
  if !exists("w:buflist")
    return
  endif

  if (len(w:buflist) > 1)
    let bufnr = w:buflist[0]
    let w:buflist = [bufnr]
  endif
endfunc

func s:Pop()
  if (len(w:buflist) > 1)
    call remove(w:buflist, 0)
    exec w:buflist[0]."b"
  endif
endfunc

func s:Push()
  if !exists("w:buflist")
    let w:buflist = []
  endif

  let fname = expand('%:p')
  let bufnr = bufnr('%')
  let bufname = bufname('%')
  if (len(w:buflist) == 0 || w:buflist[0] != bufnr)
    call insert(w:buflist, bufnr)
  endif

  if (len(w:buflist) > s:max_buflist)
    call remove(w:buflist, -1)
  endif

  "call s:Print()
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command WinBufHistPrint  call s:Print()
command WinBufHistClear  call s:Clear()
command WinBufHistPop    call s:Pop()

augroup winbufhist
  autocmd!
  autocmd BufEnter *   call s:Push()
augroup END

