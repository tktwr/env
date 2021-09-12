"======================================================
" window
"======================================================
"------------------------------------------------------
" wininfo
"------------------------------------------------------
func MyWinInfo()
  echo "columns: ".&columns
  echo "lines: ".&lines
  echo "current winwidth: ".winwidth(0)
  echo "current winheight: ".winheight(0)
  echo "current winnr: ".winnr()
  echo "last winnr: ".winnr('$')
  echo "bufnr of current win: ".winbufnr(0)
  echo "bufnr of current buf: ".bufnr('%')
  echo "bufname of current buf: ".bufname('%')
  echo "winid of current buf: ".bufwinid('%')
  echo "winnr of current buf: ".bufwinnr('%')
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func MyWinBufExchange(winnr)
  let winnr = a:winnr
  if winnr == 0
    let winnr = input("winnr? ")
  endif
  if winnr == ""
    echo "canceled"
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
  let winnr = a:winnr
  if winnr == 0
    let winnr = input("winnr? ")
  endif
  if winnr == ""
    echo "canceled"
    return
  endif

  let src_bufnr = bufnr('%')
  exec winnr."wincmd w"
  exec src_bufnr."b"
  wincmd p
endfunc

"------------------------------------------------------
" maximize window
"------------------------------------------------------
func MyWinMaximizeXToggle(max_width)
  let w = winwidth(0)
  if !exists('w:orig_width')
    let w:orig_width = w
  endif
  if w == w:orig_width
    let w = a:max_width
  else
    let w = w:orig_width
  endif
  exec "vertical resize" w
endfunc

func MyWinMaximizeYToggle(max_height)
  let h = winheight(0)
  if !exists('w:orig_height')
    let w:orig_height = h
  endif
  if h == w:orig_height
    let h = a:max_height
  else
    let h = w:orig_height
  endif
  exec "resize" h
endfunc

func MyWinMaximizeXYToggle(max_width, max_height)
  call MyWinMaximizeXToggle(a:max_width)
  call MyWinMaximizeYToggle(a:max_height)
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func MyWinResize(height)
  exec "resize" a:height
  let w:orig_height = a:height
endfunc

func MyWinVResize(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" place window
"------------------------------------------------------
func MyWinPlace(place)
  exec "wincmd " a:place
endfunc

"------------------------------------------------------
" redraw
"------------------------------------------------------
func MyRedraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  nohlsearch
  let l:dir = getcwd()
  let l:file = expand("%")
  echo printf("%s [%s]", l:file, l:dir)
  "file
  IndentGuidesToggle
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=0 MyWinInfo        call MyWinInfo()
command -nargs=1 MyWinResize      call MyWinResize(<f-args>)
command -nargs=1 MyWinVResize     call MyWinVResize(<f-args>)
command -nargs=1 Wx               call MyWinBufExchange(<f-args>)
command -nargs=1 Wc               call MyWinBufCopy(<f-args>)

command MyRedraw                  call MyRedraw()

