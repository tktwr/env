"------------------------------------------------------
" MyIDE
"------------------------------------------------------
func MyIDE()
  let l:is_fullscreen = MyIsFullscreen()
  NERDTree
  wincmd w
  if l:is_fullscreen
    vsp
    MyTerm
    wincmd l
  endif
  MyTerm
endfunc

" [OBSOLETE]
func MyIDE_old()
  let l:is_fullscreen = MyIsFullscreen()
  NERDTree
  wincmd w
  MyTerm
  wincmd W
  if l:is_fullscreen
    "Tagbar
    vsp
  endif
endfunc

"------------------------------------------------------
" NERDTree
"------------------------------------------------------
func MyNERDTreeOpen()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    "NERDTreeFind
    let l:dir = MyExpandDir("")
    exec "silent NERDTree" l:dir
  endif
endfunc

func MyNERDTreeEdit(winnr)
  exec a:winnr."wincmd w"
  wincmd p
  call nerdtree#ui_glue#invokeKeyMap("<CR>")
endfunc

"------------------------------------------------------
" git
"------------------------------------------------------
func MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

func MyGV()
  GV --all
endfunc

"------------------------------------------------------
" func tab
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
" command
"------------------------------------------------------
command MyIDE                   call MyIDE()
command MyNERDTreeOpen          call MyNERDTreeOpen()
command MyNERDTreeToggle        NERDTreeToggle
command MyTagbarToggle          TagbarToggle
command MyGstatusToggle         call MyGstatusToggle()
command MyGV                    call MyGV()

"------------------------------------------------------
" command in new tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff      call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff   call MyTabDirDiff(<f-args>)
command MyTabDirDiffQuit        call MyTabDirDiffQuit()
command MyTabClosePrev          call MyTabClosePrev()

