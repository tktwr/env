"======================================================
" MyIDE
"======================================================
func MyIDE()
  let l:is_fullscreen = TtIsFullscreen()
  call MyLeftWin()
  wincmd w
  if l:is_fullscreen
    vsp
    MyTerm
    wincmd w
  endif
  MyTerm
endfunc

func s:MyWinInitSizeForEachWin()
  if &buftype == 'terminal'
    exec "resize" g:my_term_winheight
  elseif winnr() == 2 && &filetype == 'fern'
    exec "resize" g:my_fern_2nd_winheight
  endif
endfunc

func MyWinInitSize()
  1wincmd w
  exec "normal \<C-W>="
  exec "vertical resize" g:my_left_winwidth
  2,$windo call s:MyWinInitSizeForEachWin()
endfunc

func IdeSideBarToggle()
  1wincmd w
  if winwidth(0) < 5
    exec "vertical resize" g:my_left_winwidth
  else
    exec "vert resize 0"
  endif
  wincmd p
endfunc

"------------------------------------------------------
" redraw
"------------------------------------------------------
func MyRedraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  nohlsearch
  let l:dir = getcwd()
  let l:file = expand("%")
  echo printf("%s [%s]", l:file, l:dir)
  "file
  IndentGuidesToggle
endfunc

