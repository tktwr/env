"======================================================
" common
"======================================================
"------------------------------------------------------
" util
"------------------------------------------------------
func TtGetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

"------------------------------------------------------
" buffer
"------------------------------------------------------
func TtClear()
  silent %d _
endfunc

func TtPut0(text)
  silent 0put =a:text
endfunc

func TtPut(text)
  silent put =a:text
endfunc

func TtRemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func TtRemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
endfunc

func TtRemoveBeginEndSpaces(line)
  return TtRemoveBeginSpaces(TtRemoveEndSpaces(a:line))
endfunc

func TtSystem(cmd)
  let out = system(a:cmd)
  return substitute(out, "\<CR>", '', 'g')
endfunc

"------------------------------------------------------
" window
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

func TtIsEmptyTab()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
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

func TtStatuslineFname()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = "%6*"
  if (cwd != dir)
    let color = "%3*"
  endif
  "return color."%<%f"."%0*"
  return color."%t"."%0*"
endfunc

func TtStatuslineEnc()
  let fenc = &fenc != '' ? &fenc : &enc
  let ff = &ff
  return '['.fenc.','.ff.']'
endfunc

func TtStatuslineForSideBar()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "\ %t"
  let stat.= "\ %m%y"
  return stat
endfunc

func TtSetStatuslineForSideBar()
  setl statusline=%!TtStatuslineForSideBar()
endfunc

