"======================================================
" WinBufHist
"======================================================
if exists("g:loaded_winbufhist")
  finish
endif
let g:loaded_winbufhist = 1

"------------------------------------------------------
" private func
"------------------------------------------------------
func s:Print()
  "set cmdheight=10
  for i in w:buflist
    if i == 0
      "echo "- 0"
    else
      echo "-" i bufname(i)
    endif
  endfor
endfunc

func s:Clear()
  let bufnr = w:buflist[0]
  let w:buflist = [bufnr, 0]
endfunc

func s:Prev()
  if (len(w:buflist) > 2)
    call remove(w:buflist, 0)
    exec w:buflist[0]."b"
  endif
endfunc

func s:Push()
  if !exists("w:buflist")
    let w:buflist = [0]
  endif

  let fname = expand('%:p')
  let bufnr = bufnr('%')
  let bufname = bufname('%')
  if (w:buflist[0] != bufnr)
    call insert(w:buflist, bufnr)
  endif
  "call s:Print()
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command WinBufHistPrint  call s:Print()
command WinBufHistClear  call s:Clear()
command WinBufHistPrev   call s:Prev()

augroup winbufhist
  autocmd!
  autocmd BufEnter *   call s:Push()
augroup END

