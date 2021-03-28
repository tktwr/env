"======================================================
" window
"======================================================
func MyMemo(...)
  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above Memo"
  else
    exec "above Memo" a:1
  endif
  wincmd p
  close
endfunc

func MyHelp(...)
  if &filetype == "help"
    let close_origwin=0
  else
    let close_origwin=1
  endif

  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif
  if close_origwin
    wincmd p
    close
  endif
endfunc

func MyMan(word)
  exec "vertical resize" g:my_help_winwidth
  if &filetype == "ref-man"
    exec "above Ref man" a:word
  else
    exec "above Ref man" a:word
    wincmd p
    close
  endif
endfunc

func MyPydoc(word)
  exec "vertical resize" g:my_help_winwidth
  if &filetype == "ref-pydoc"
    exec "above Ref pydoc" a:word
  else
    exec "above Ref pydoc" a:word
    wincmd p
    close
  endif
endfunc

"------------------------------------------------------
" wininfo
"------------------------------------------------------
func MyWinInfo()
  echo "columns: ".&columns
  echo "lines: ".&lines
  echo "current winwidth: ".winwidth(0)
  echo "current winheight: ".winheight(0)
  echo "winnr: ".winnr('$')
  echo "bufname: ".bufname('%')
  echo "bufnr: ".bufnr('%')
  echo "bufwinid: ".bufwinid('%')
  echo "bufwinnr: ".bufwinnr('%')
endfunc

"------------------------------------------------------
" resize window
"------------------------------------------------------
func MyWinMaximizeXToggle()
  let l:width = winwidth(0)
  if !exists('w:orig_width')
    let w:orig_width = l:width
  endif
  if l:width == w:orig_width
    let l:width = ""
  else
    let l:width = w:orig_width
  endif
  exec "vertical resize" l:width
endfunc

func MyWinMaximizeYToggle()
  let l:height = winheight(0)
  if !exists('w:orig_height')
    let w:orig_height = l:height
  endif
  if l:height == w:orig_height
    let l:height = ""
  else
    let l:height = w:orig_height
  endif
  exec "resize" l:height
endfunc

func MyWinMaximizeXYToggle()
  call MyWinMaximizeXToggle()
  call MyWinMaximizeYToggle()
endfunc

func MyWinResize(height)
  exec "resize" a:height
  let w:orig_height = a:height
endfunc

func MyWinPlace(place)
  exec "wincmd " a:place
endfunc

"------------------------------------------------------
" MyIDE
"------------------------------------------------------
func MyIDE()
  NERDTree
  wincmd l
  "Tagbar
  MyTerm 0
endfunc

"------------------------------------------------------
" Gstatus
"------------------------------------------------------
func MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    Gstatus
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

"------------------------------------------------------
" NERDTree
"------------------------------------------------------
func MyOpenNERDTree(url)
  let l:dir = MyExpandDir(a:url)
  exec "silent NERDTree" l:dir
endfunc

func MyNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    call MyOpenNERDTree("")
    "NERDTreeFind
  endif
endfunc

"======================================================
" terminal
"======================================================
"------------------------------------------------------
" open terminal
"------------------------------------------------------
func MyIsFullscreen()
  let l:is_fullscreen = 0
  if v:echospace > 150
    let l:is_fullscreen = 1
  endif
  return l:is_fullscreen
endfunc

func MyTerm(...)
  if a:0 == 0
    let l:type = 0
  else
    let l:type = a:1
  endif
  if l:type == 0
    let l:is_fullscreen = MyIsFullscreen()
    if l:is_fullscreen
      exec "below term ++rows=".g:my_term_winheight
    else
      exec "bot term ++rows=".g:my_term_winheight
    endif
    set winfixheight
  elseif l:type == 1
    tabedit
    bot term
    only
  elseif l:type == 2
    tabedit
    bot term
    only
    bot term
  endif
endfunc

func MyTermV()
  vnew
  exec "term ++rows=1"
  wincmd p
  close
  exec "resize".g:my_term_winheight
  set winfixheight
endfunc

"------------------------------------------------------
" editor to terminal
"------------------------------------------------------
" send a cmd to a terminal
func MyTermSendCmd(cmd)
  let l:nr = bufnr("!/usr/bin/bash")
  let l:cmd = a:cmd
  if (l:cmd == "")
    let l:cmd = getline('.')
  endif
	call term_sendkeys(l:nr, l:cmd."\<CR>")
endfunc

" send 'cd dir' to a terminal
func MyTermSendCd(dir)
  let l:nr = bufnr("!/usr/bin/bash")
  let l:dir = MyExpandDir(a:dir)
  call term_sendkeys(l:nr, "cd ".l:dir."\<CR>")
  let l:winnr = bufwinnr("!/usr/bin/bash")
  exec l:winnr."wincmd w"
endfunc

"------------------------------------------------------
" terminal to editor
"------------------------------------------------------
func Tapi_Exec(_, cmdline)
  exec a:cmdline
endfunc

func Tapi_ExecInPrevWin(_, cmdline)
  wincmd p
  exec a:cmdline
endfunc

func Tapi_ExecInNewTab(_, cmdline)
  tabedit
  exec a:cmdline
endfunc

func MyNERDTreeT2E(dir)
  exec "NERDTree" a:dir

  let l:is_fullscreen = MyIsFullscreen()
  if !l:is_fullscreen
    exec "wincmd p"
    call MyWinPlace("J")
    exec "wincmd p"
  endif
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

func MyTabGstatus()
  tabedit
  call MyGstatusToggle()
endfunc

func MyTabGV()
  tabedit
  GV --all
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=? MyMemo         call MyMemo(<f-args>)
command -nargs=? MyHelp         call MyHelp(<f-args>)
command -nargs=1 MyMan          call MyMan(<f-args>)
command -nargs=1 MyPydoc        call MyPydoc(<f-args>)

command -nargs=0 MyWinInfo      call MyWinInfo()
command -nargs=1 MyWinResize    call MyWinResize(<f-args>)

command -nargs=? MyTerm         call MyTerm(<f-args>)
command -nargs=0 MyTermV        call MyTermV()
command -nargs=1 -complete=dir  MyNERDTreeT2E  call MyNERDTreeT2E(<f-args>)

command MyIDE                   call MyIDE()
command MyGstatusToggle         call MyGstatusToggle()
command MyNERDTreeToggle        call MyNERDTreeToggle()
command MyTagbarToggle          TagbarToggle

"------------------------------------------------------
" command tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff      call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff   call MyTabDirDiff(<f-args>)
command MyTabDirDiffQuit        call MyTabDirDiffQuit()
command MyTabGstatus            call MyTabGstatus()
command MyTabGV                 call MyTabGV()

