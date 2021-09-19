"======================================================
" Window Buffer List
"======================================================
if v:version < 802
  finish
endif

if exists("g:loaded_wbl")
  finish
endif
let g:loaded_wbl = 1

"------------------------------------------------------
" set global variables
"------------------------------------------------------
func s:SetGlobalVars()
  " set defaults
  let s:wbl_key = "\<End>"
  let s:wbl_max = 10

  " set global variables
  if exists("g:wbl_key")
    let s:wbl_key = g:wbl_key
  endif
  if exists("g:wbl_max")
    let s:wbl_max = g:wbl_max
  endif
endfunc

"------------------------------------------------------
" util
"------------------------------------------------------
func WblFind(list_of_bufnr, pattern)
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

func WblSelect(pattern, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let idx = WblFind(w:buflist, a:pattern)
  if (idx != -1)
    exec w:buflist[idx]."b"
  endif
endfunc

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func WblPopupMenuFilter(id, key)
  let w:dst_winnr = 0
  if a:key == s:wbl_key
    call popup_close(a:id, 0)
    return 1
  elseif a:key == "c"
    call popup_close(a:id, 0)
    call WblCopy()
    return 1
  elseif a:key == "p"
    call popup_close(a:id, 0)
    call WblPaste()
    return 1
  elseif a:key == "C"
    call popup_close(a:id, 0)
    call WblClear()
    return 1
  elseif a:key == "d"
    let w:dst_winnr = -1
    return popup_filter_menu(a:id, "\<CR>")
  elseif match(a:key, "[1-9]") == 0
    let w:dst_winnr = a:key + 0
    return popup_filter_menu(a:id, "\<CR>")
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func WblPopupMenuHandler(id, result)
  if a:result == 0
  elseif a:result > 0
    let idx = a:result - 1

    let bufnr = w:buflist[idx]
    if w:dst_winnr == 0
      exec bufnr."b"
    elseif w:dst_winnr == -1
      if len(w:buflist) > 1
        call WblBufDelete(bufnr)
      else
        enew
        call WblPush()
        call WblBufDelete(bufnr)
      endif
    else
      let bufname = bufname(bufnr)
      let absname = fnamemodify(bufname, ":p")
      call BmkEdit(absname, w:dst_winnr)
    endif
  endif
endfunc

func WblPopupMenu()
  if !exists("w:buflist")
    return
  endif

  let l = []
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    call add(l, s)
  endfor
  call popup_menu(l, #{
    \ filter: 'WblPopupMenuFilter',
    \ callback: 'WblPopupMenuHandler',
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
func WblPrintMenu()
  call WblPopupMenu()
endfunc

func WblPrint()
  for i in w:buflist
    let s = printf("%3d %s ", i, bufname(i))
    echo s
  endfor
endfunc

func WblCopy()
  let s:buflist = w:buflist
endfunc

func WblPaste()
  let w:buflist += s:buflist
  if (len(w:buflist) > s:wbl_max)
    call remove(w:buflist, s:wbl_max, -1)
  endif
endfunc

"------------------------------------------------------
func WblClear()
  if !exists("w:buflist")
    return
  endif

  if (len(w:buflist) > 1)
    let bufnr = w:buflist[0]
    let w:buflist = [bufnr]
  endif
endfunc

func WblRemoveBufnr(list, bufnr)
  let i = match(a:list, a:bufnr)
  if i != -1
    call remove(a:list, i)
  endif
endfunc

func WblPop()
  if (len(w:buflist) > 1)
    call remove(w:buflist, 0)
    exec w:buflist[0]."b"
  endif
endfunc

func WblPush()
  if !exists("w:buflist")
    let w:buflist = []
  endif

  let bufnr = bufnr('%')
  call WblRemoveBufnr(w:buflist, bufnr)
  call insert(w:buflist, bufnr)

  if (len(w:buflist) > s:wbl_max)
    call remove(w:buflist, -1)
  endif

  "call WblPrint()
endfunc

func WblBufDelete(bufnr)
  call WblRemoveBufnr(w:buflist, a:bufnr)
  exec w:buflist[0]."b"
  exec "bdelete" a:bufnr
endfunc

"------------------------------------------------------
func WblPrev()
  if !exists("w:buflist") || (len(w:buflist) <= 1)
    return
  endif

  let bufnr = w:buflist[0]
  call remove(w:buflist, 0)
  call add(w:buflist, bufnr)
  exec w:buflist[0]."b"
endfunc

func WblNext()
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
  command WblPrint  call WblPrintMenu()
else
  command WblPrint  call WblPrint()
endif

command WblPrev   call WblPrev()
command WblNext   call WblNext()
command WblClear  call WblClear()
command WblPop    call WblPop()

augroup ag_wbl
  autocmd!
  autocmd BufEnter *   call WblPush()
  autocmd WinEnter *   call WblPush()
augroup END

"------------------------------------------------------
" init
"------------------------------------------------------
func s:Init()
  call s:SetGlobalVars()
endfunc

call s:Init()

