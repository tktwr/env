"------------------------------------------------------
" statusline
"------------------------------------------------------
func TtStatuslineWinNr()
  return printf("[%s] ", winnr())
endfunc

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

