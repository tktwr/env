"======================================================
" WinBufHist
"======================================================
if exists("g:loaded_winbufhist")
  finish
endif
let g:loaded_winbufhist = 1

let s:max_buflist = 10

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func WinBufHistPopupMenuFilter(id, key)
  if a:key == 'c'
     call popup_close(a:id, 0)
     return 1
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func WinBufHistPopupMenuHandler(id, result)
  if a:result == 0
    call s:Clear()
  elseif a:result > 0
    let idx = a:result - 1
    echo printf("%d, %d", idx, w:buflist[idx])
    exec w:buflist[idx]."b"
  endif
endfunc

func WinBufHistPopupMenu()
  let l = []
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    call add(l, s)
  endfor
  call popup_menu(l, #{
    \ filter: 'WinBufHistPopupMenuFilter',
    \ callback: 'WinBufHistPopupMenuHandler',
    \ border: [0,0,0,0],
    \ padding: [0,0,0,0],
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ moved: 'WORD',
    \ })
endfunc

"------------------------------------------------------
" private func
"------------------------------------------------------
func s:PrintMenu()
  call WinBufHistPopupMenu()
endfunc

func s:Print()
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    echo s
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
if v:version >= 802
  command WinBufHistPrint  call s:PrintMenu()
else
  command WinBufHistPrint  call s:Print()
endif

command WinBufHistClear  call s:Clear()
command WinBufHistPop    call s:Pop()

augroup winbufhist
  autocmd!
  autocmd BufEnter *   call s:Push()
augroup END

