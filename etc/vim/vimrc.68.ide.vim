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
  let l:cmd = a:cmd
  if (l:cmd == "")
    let l:cmd = getline('.')
  endif
  wincmd j
  let l:bufnr = winbufnr(0)
	call term_sendkeys(l:bufnr, l:cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func MyIDESendCdE2T(dir)
  let l:dir = MyExpandDir(a:dir)

  wincmd j

  exec "lcd" l:dir
  if &buftype == 'terminal'
    let l:bufnr = winbufnr(0)
    call term_sendkeys(l:bufnr, "cd ".l:dir."\<CR>")
  endif
endfunc

"------------------------------------------------------
" terminal to terminal
"------------------------------------------------------
" send 'cd dir' to a terminal
func MyIDESendCdT2T(dir, winnr)
  let l:dir = MyExpandDir(a:dir)

  exec a:winnr."wincmd w"

  exec "lcd" l:dir
  if &buftype == 'terminal'
    let l:bufnr = winbufnr(0)
    call term_sendkeys(l:bufnr, "cd ".l:dir."\<CR>")
  endif
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
func MyIDESendCdN2T()
  let l:dir = getcwd()
  let winnr = MyWinFindTerm()
  if winnr != -1
    let l:bufnr = winbufnr(0)
    call term_sendkeys(l:bufnr, "cd ".l:dir."\<CR>")
    exec "lcd" l:dir
  endif
endfunc

"------------------------------------------------------
" terminal to nerdtree
"------------------------------------------------------
func MyIDESendCdT2N(dir)
  exec "NERDTree" a:dir
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

