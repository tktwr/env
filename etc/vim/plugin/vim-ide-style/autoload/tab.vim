"------------------------------------------------------
" tab
"------------------------------------------------------
func MyTabDiff(file1, file2)
  exec "tabedit" a:file2
  exec "vertical diffsplit" a:file1
endfunc

func MyTabDirDiff(dir1, dir2)
  tabedit
  exec "DirDiff" a:dir1 a:dir2
  redraw!
endfunc

func MyTabDirDiffQuit()
  exec "DirDiffQuit"
  tabclose
endfunc

func TtIsEmptyTab()
  let last_winnr = winnr('$')
  if last_winnr == 1 && &filetype == ""
    return 1
  endif
  return 0
endfunc

func MyTabClosePrev()
  let winnr = TtFindFirstTerm()
  if winnr == -1
    " terminal is not found in the tab
    tabclose
    if TtIsEmptyTab()
      " close redundant empty tab
      tabclose
    endif
    tabprev
  endif
endfunc

