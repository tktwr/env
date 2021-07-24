"------------------------------------------------------
" MyIDE
"------------------------------------------------------
func MyIDE()
  let l:is_fullscreen = MyIsFullscreen()
  "NERDTree
  call MyFernToggle()
  wincmd w
  if l:is_fullscreen
    vsp
    MyTerm
    wincmd l
  endif
  MyTerm
endfunc

func s:MyWinInitSizeForEachWin()
  if &buftype == 'terminal'
    exec "resize" g:my_term_winheight
  else
    exec "normal \<C-W>="
  endif
endfunc

func MyWinInitSize()
  1wincmd w
  exec "vertical resize" g:my_left_winwidth
  2,$windo call s:MyWinInitSizeForEachWin()
endfunc

"------------------------------------------------------
" buffer
"------------------------------------------------------
func MyBufDelete()
  let nr = bufnr('%')
  enew
  exec "bdelete" nr
endfunc

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

func MyTabClosePrev()
  let winnr = MyWinFindTerm()
  if winnr == -1
    " terminal is not found in the tab
    tabclose
    if MyIsEmptyTab()
      " close redundant empty tab
      tabclose
    endif
    tabprev
  endif
endfunc

"------------------------------------------------------
" editor to terminal
"------------------------------------------------------
" send a cmd to a terminal
func MyIDESendCmdE2T(cmd)
  let cmd = a:cmd
  if (cmd == "")
    let cmd = getline('.')
  endif
  wincmd j
  let bufnr = winbufnr(0)
	call term_sendkeys(bufnr, cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func MyIDESendCdE2T(dir)
  let dir = MyExpandDir(a:dir)
  wincmd j
  let winnr = winnr()
  call BmkEditDir(dir, winnr)
endfunc

"------------------------------------------------------
" terminal to terminal
"------------------------------------------------------
" send 'cd dir' to a terminal
func MyIDESendCdT2T(dir, winnr)
  let dir = MyExpandDir(a:dir)
  call BmkEditDir(dir, a:winnr)
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func MyIDEVResizeT2E(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command                         MyIDE            call MyIDE()
command                         MyWinInitSize    call MyWinInitSize()

command                         MyBufDelete      call MyBufDelete()

"------------------------------------------------------
" command in new tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff        call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff     call MyTabDirDiff(<f-args>)
command                         MyTabDirDiffQuit call MyTabDirDiffQuit()
command                         MyTabClosePrev   call MyTabClosePrev()

command -nargs=1                MyIDEVResizeT2E  call MyIDEVResizeT2E(<f-args>)
command -nargs=+ -complete=dir  MyIDESendCdT2T   call MyIDESendCdT2T(<f-args>)

