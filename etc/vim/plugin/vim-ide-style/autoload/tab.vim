"------------------------------------------------------
" tab
"------------------------------------------------------
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

"------------------------------------------------------
" diff
"------------------------------------------------------
func MyTabDiff(file1, file2)
  exec "tabedit" a:file2
  exec "vertical diffsplit" a:file1
endfunc

"------------------------------------------------------
" dirdiff
"------------------------------------------------------
func MyDirDiff(dir1, dir2)
  let dir1 = substitute(a:dir1, ' ', '\\ ', 'g')
  let dir2 = substitute(a:dir2, ' ', '\\ ', 'g')

  exec "DirDiff" dir1 dir2
  redraw!
endfunc

func MyTabDirDiff(dir1, dir2)
  tabedit
  call MyDirDiff(a:dir1, a:dir2)
endfunc

func MyTabDirDiffQuit()
  exec "DirDiffQuit"
  tabclose
endfunc

