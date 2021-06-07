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
" NERDTree
"------------------------------------------------------
func MyNERDTreeOpen()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    "NERDTreeFind
    let l:dir = expand("%:p:h")
    exec "silent NERDTree" l:dir
  endif
endfunc

"------------------------------------------------------
" git
"------------------------------------------------------
func MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Git
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
func MyIDESendCdE2T(dir="")
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
  wincmd k
  exec "vertical resize" a:width
  wincmd p
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

"------------------------------------------------------
" nerdtree and terminal
"------------------------------------------------------
func MyNERDTreeSelected()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        return n.path.str()
    endif
    return ""
endfunc

func MyNERDTreeEdit(winnr)
  let selected = MyNERDTreeSelected()

  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

"------------------------------------------------------
" terminal to nerdtree
"------------------------------------------------------
func MyIDESendCdT2N(dir)
  call BmkSide(1)
  exec "NERDTree" a:dir
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command MyIDE                   call MyIDE()
command MyWinInitSize           call MyWinInitSize()
command MyNERDTreeOpen          call MyNERDTreeOpen()
command MyNERDTreeToggle        NERDTreeToggle
command MyTagbarToggle          TagbarToggle
command MyGstatusToggle         call MyGstatusToggle()
command MyGV                    call MyGV()

command -nargs=1                MyIDEVResizeT2E call MyIDEVResizeT2E(<f-args>)
command -nargs=1 -complete=dir  MyIDESendCdT2N  call MyIDESendCdT2N(<f-args>)
command -nargs=+ -complete=dir  MyIDESendCdT2T  call MyIDESendCdT2T(<f-args>)

"------------------------------------------------------
" command in new tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff      call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff   call MyTabDirDiff(<f-args>)
command MyTabDirDiffQuit        call MyTabDirDiffQuit()
command MyTabClosePrev          call MyTabClosePrev()

