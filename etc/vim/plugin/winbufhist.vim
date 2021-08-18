"======================================================
" WinBufHist
"======================================================
if exists("g:loaded_winbufhist")
  finish
endif
let g:loaded_winbufhist = 1

let g:winbufhist_key = "\<C-U>"
let g:winbufhist_max = 10

let s:winbufhist_key = g:winbufhist_key
let s:winbufhist_max = g:winbufhist_max

"------------------------------------------------------
" util
"------------------------------------------------------
func WinBufHistFind(list_of_bufnr, pattern)
  let idx = 0
  for i in a:list_of_bufnr
    let s = bufname(i)
    if (match(s, a:pattern) == 0)
      return idx
    endif
    let idx = idx + 1
  endfor
  return -1
endfunc

func WinBufHistFindNERDTree()
  exec "1wincmd w"
  let idx = WinBufHistFind(w:buflist, 'NERD_tree')
  if (idx != -1)
    exec w:buflist[idx]."b"
  endif
endfunc

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func WinBufHistPopupMenuFilter(id, key)
  let w:dst_winnr = 0
  if a:key == s:winbufhist_key
    call popup_close(a:id, 0)
    return 1
  elseif a:key == "c"
    call popup_close(a:id, 0)
    call WinBufHistClear()
    return 1
  elseif match(a:key, "[1-9]") == 0
    let w:dst_winnr = a:key + 0
    return popup_filter_menu(a:id, "\<Enter>")
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func WinBufHistPopupMenuHandler(id, result)
  echo "result:".a:result
  if a:result == 0
  elseif a:result > 0
    let idx = a:result - 1
    let bufnr = w:buflist[idx]
    "echo printf("%d, %d", idx, bufnr)
    if w:dst_winnr == 0
      exec bufnr."b"
    else
      let bufname = bufname(bufnr)
      let absname = fnamemodify(bufname, ":p")
      exec BmkEdit(absname, w:dst_winnr)
    endif
  endif
endfunc

func WinBufHistPopupMenu()
  if !exists("w:buflist")
    return
  endif

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
func WinBufHistPrintMenu()
  call WinBufHistPopupMenu()
endfunc

func WinBufHistPrint()
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    echo s
  endfor
endfunc

func WinBufHistClear()
  if !exists("w:buflist")
    return
  endif

  if (len(w:buflist) > 1)
    let bufnr = w:buflist[0]
    let w:buflist = [bufnr]
  endif
endfunc

func WinBufHistRemoveBufnr(list, bufnr)
  let pattern = '\<'.a:bufnr.'\>'
  let i = match(a:list, pattern)
  if i != -1
    call remove(a:list, i)
  endif
endfunc

func WinBufHistPop()
  if (len(w:buflist) > 1)
    call remove(w:buflist, 0)
    exec w:buflist[0]."b"
  endif
endfunc

func WinBufHistPush()
  if !exists("w:buflist")
    let w:buflist = []
  endif

  let bufnr = bufnr('%')
  call WinBufHistRemoveBufnr(w:buflist, bufnr)
  call insert(w:buflist, bufnr)

  if (len(w:buflist) > s:winbufhist_max)
    call remove(w:buflist, -1)
  endif

  "call WinBufHistPrint()
endfunc

func WinBufHistPrev()
  if !exists("w:buflist") || (len(w:buflist) <= 1)
    return
  endif

  let bufnr = w:buflist[0]
  call remove(w:buflist, 0)
  call add(w:buflist, bufnr)
  exec w:buflist[0]."b"
endfunc

func WinBufHistNext()
  if !exists("w:buflist") || (len(w:buflist) <= 1)
    return
  endif

  let bufnr = w:buflist[-1]
  call remove(w:buflist, -1)
  call insert(w:buflist, bufnr)
  exec w:buflist[0]."b"
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
if v:version >= 802
  command WinBufHistPrint  call WinBufHistPrintMenu()
else
  command WinBufHistPrint  call WinBufHistPrint()
endif

command WinBufHistPrev   call WinBufHistPrev()
command WinBufHistNext   call WinBufHistNext()
command WinBufHistClear  call WinBufHistClear()
command WinBufHistPop    call WinBufHistPop()

augroup ag_winbufhist
  autocmd!
  autocmd BufEnter *   call WinBufHistPush()
augroup END

