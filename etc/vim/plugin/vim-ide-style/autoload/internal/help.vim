func MyHelp(...)
  if &filetype == "help"
    let start_from_help_win=1
  else
    let start_from_help_win=0
  endif

  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif

  if !start_from_help_win
    call MyClosePrevWin()
  endif
endfunc

