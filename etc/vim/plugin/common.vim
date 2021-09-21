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

func TtGotoWinnr(winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif
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

"------------------------------------------------------
" statusline
"------------------------------------------------------
func TtStatuslineWinNr()
  return printf("[%s] ", winnr())
endfunc

func TtStatuslineFname()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = ""
  if (cwd != dir)
    let color = "%3*"
  else
    let color = "%6*"
  endif
  "return color."%f"."%0* "
  return color."%t"."%0* "
endfunc

func TtStatuslineIndicator()
  return "%m%r%h%w%q%y"
endfunc

func TtStatuslineFileEnc()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

func TtStatuslineLineInfo()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func TtStatuslineForSideBar()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "%t "
  let stat.= "%m%y"
  return stat
endfunc

func TtSetStatuslineForSideBar()
  setl statusline=%!TtStatuslineForSideBar()
endfunc

