"------------------------------------------------------
" buffer
"------------------------------------------------------
func MyBufDelete()
  let nr = bufnr('%')
  enew
  exec "bdelete" nr
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func MyWinBufExchange(winnr)
  let winnr = MyPrompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  let dst_bufnr = bufnr('%')
  exec src_bufnr."b"
  wincmd p
  exec dst_bufnr."b"
endfunc

func MyWinBufCopy(winnr)
  let winnr = MyPrompt("Winnr? ", a:winnr)
  if winnr == ""
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

