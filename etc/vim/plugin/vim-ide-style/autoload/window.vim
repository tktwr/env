"======================================================
" window
"======================================================
"------------------------------------------------------
" query
"------------------------------------------------------
func TtInSideBar()
  let winnr = winnr()
  if (winnr <= 2 && winwidth(0) <= g:my_left_winwidth)
    return 1
  else
    return 0
  endif
endfunc

func TtIsFullscreen()
  if &columns > 150
    return 1
  else
    return 0
  endif
endfunc

"------------------------------------------------------
" move
"------------------------------------------------------
func TtGotoWinnr(winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif
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
" close window
"------------------------------------------------------
func MyClosePrevWin()
  let curr_winnr = winnr()
  wincmd p
  call WblCopy()
  close
  exec curr_winnr."wincmd w"
  call WblPaste()
endfunc

"------------------------------------------------------
" find the first terminal window
"------------------------------------------------------
func TtFindFirstTerm()
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

"------------------------------------------------------
" find the first editor window
"------------------------------------------------------
func TtFindFirstEditor()
  let last_winnr = winnr('$')
  let i = 1
  while i <= last_winnr
    exec i."wincmd w"
    if !TtInSideBar()
      return i
    endif
    let i = i + 1
  endwhile
  return -1
endfunc

"------------------------------------------------------
" find the last editor window from the current window
"------------------------------------------------------
func TtFindLastEditor()
  let curr_winnr = winnr()
  let i = curr_winnr
  while i > 0
    exec i."wincmd w"
    if &buftype != 'terminal'
      return i
    endif
    let i = i - 1
  endwhile
  return -1
endfunc

"------------------------------------------------------
" find an editor
"------------------------------------------------------
" winnr == -2: the first editor window
" winnr == -1: the last editor window
" winnr ==  0: the current window
" winnr >=  1: the specified window
func TtFindEditor(winnr)
  let winnr = a:winnr
  if winnr == -2
    let winnr = TtFindFirstEditor()
  elseif winnr == -1
    let winnr = TtFindLastEditor()
  endif
  return winnr
endfunc

