"------------------------------------------------------
" util
"------------------------------------------------------
func TtInSideBar()
  let winnr = winnr()
  if (winnr <= 2 && winwidth(0) <= g:my_left_winwidth)
    return 1
  else
    return 0
  endif
endfunc

func TtClear()
  silent %d _
endfunc

func TtPut0(text)
  silent 0put =a:text
endfunc

func TtPut(text)
  silent put =a:text
endfunc

func TtGetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

func TtRemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func TtRemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
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
" statusline
"------------------------------------------------------
func TtStatuslineWinNr()
  let winnr = winnr()
  return '['.winnr.']'
endfunc

func TtStatusline()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "\ %t"
  return stat
endfunc

func TtSetStatusline()
  setl statusline=%!TtStatusline()
endfunc

