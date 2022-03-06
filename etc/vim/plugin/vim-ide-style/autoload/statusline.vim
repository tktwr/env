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

func TtStatuslineFileType()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = "[".ft."]"
  else
    let type = "[".ft.",".syn."]"
  endif

  return type
endfunc

func TtStatuslineIndicator()
  return "%m%r%w%q"
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

func TtStatuslineSeparator()
  return "%<%="
endfunc

"------------------------------------------------------
" statusline for buffer
"------------------------------------------------------
func MyStatusline()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= TtStatuslineFname()
  let stat.= "%{TtStatuslineFileType()}"
  let stat.= TtStatuslineIndicator()
  let stat.= "%{TtStatuslineFileEnc()}"
  let stat.= TtStatuslineSeparator()
  let stat.= TtStatuslineLineInfo()

  if $MY_PROMPT_TYPE >= 3
    let stat.= "%6*%{FugitiveStatusline()}%0*"
  endif
  return stat
endfunc

"------------------------------------------------------
" statusline for sidebar
"------------------------------------------------------
func TtStatuslineForSideBar()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "%t "
  let stat.= "%{TtStatuslineFileType()}"
  let stat.= TtStatuslineIndicator()
  let stat.= TtStatuslineSeparator()
  let stat.= "[%c,%l]"
  return stat
endfunc

func TtSetStatuslineForSideBar()
  setl statusline=%!TtStatuslineForSideBar()
endfunc

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func MyStatuslineForTerm()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "terminal:%n"
  let stat.= TtStatuslineSeparator()
  let stat.= "%{MyCWD()}"
  return stat
endfunc

func MySetStatuslineForTerm()
  setl statusline=%!MyStatuslineForTerm()
endfunc

