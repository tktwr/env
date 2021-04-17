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
  let src_bufnr = bufnr('%')
  exec a:winnr."wincmd w"
  let dst_bufnr = bufnr('%')
  exec src_bufnr."b"
  wincmd p
  exec dst_bufnr."b"
endfunc

"------------------------------------------------------
" window move
"------------------------------------------------------
func MyIsEmptyTab()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
endfunc

func MyWinFindTerm()
  let last_winnr = winnr('$')
  let i = 1
  while i <= last_winnr
    exec i."wincmd w"
    if &buftype == 'terminal'
      return i
    endif
    let i = i + 1
  endwhile
  return -1
endfunc

func MyWinMoveTerm()
  let winnr = MyWinFindTerm()
  if winnr != -1
    exec winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func MyWinMaximizeXToggle()
  let l:width = winwidth(0)
  if !exists('w:orig_width')
    let w:orig_width = l:width
  endif
  if l:width == w:orig_width
    let l:width = ""
  else
    let l:width = w:orig_width
  endif
  exec "vertical resize" l:width
endfunc

func MyWinMaximizeYToggle()
  let l:height = winheight(0)
  if !exists('w:orig_height')
    let w:orig_height = l:height
  endif
  if l:height == w:orig_height
    let l:height = ""
  else
    let l:height = w:orig_height
  endif
  exec "resize" l:height
endfunc

func MyWinMaximizeXYToggle()
  call MyWinMaximizeXToggle()
  call MyWinMaximizeYToggle()
endfunc

func MyWinResize(height)
  exec "resize" a:height
  let w:orig_height = a:height
endfunc

func MyWinVResize(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

func MyWinVResizeT2E(width)
  wincmd k
  exec "vertical resize" a:width
  wincmd p
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

func MyWinPlace(place)
  exec "wincmd " a:place
endfunc

func MyIsFullscreen()
  if &columns > 150
    return 1
  else
    return 0
  endif
endfunc

func MyRedraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  nohlsearch
  let l:dir = getcwd()
  let l:file = expand("%")
  echo "cwd : ".l:dir
  echo "file: ".l:file
  "file
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=0 MyWinInfo       call MyWinInfo()
command -nargs=1 MyWinResize     call MyWinResize(<f-args>)
command -nargs=1 MyWinVResize    call MyWinVResize(<f-args>)
command -nargs=1 MyWinVResizeT2E call MyWinVResizeT2E(<f-args>)

command MyRedraw                 call MyRedraw()

