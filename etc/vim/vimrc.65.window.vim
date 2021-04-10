"======================================================
" window
"======================================================
func MyTrans()
  exec "below term ++rows=".g:my_trans_winheight." ++close trans -I -b"
endfunc

func MyDict()
  exec "below term ++rows=".g:my_trans_winheight." ++close trans -I"
endfunc

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
  echo "current winnr: ".winnr()
  echo "last winnr: ".winnr('$')
  echo "bufnr of current win: ".winbufnr(0)
  echo "bufnr of current buf: ".bufnr('%')
  echo "bufname of current buf: ".bufname('%')
  echo "winid of current buf: ".bufwinid('%')
  echo "winnr of current buf: ".bufwinnr('%')
endfunc

"------------------------------------------------------
" buffer exchange
"------------------------------------------------------
func MyWinBufExchange(winnr)
  let src_bufnr = bufnr('%')
  exec a:winnr."wincmd w"
  let dst_bufnr = bufnr('%')
  exec src_bufnr."b"
  wincmd p
  exec dst_bufnr."b"
endfunc

"------------------------------------------------------
" window move
"------------------------------------------------------
func MyWinFindTerm()
  let last_winnr = winnr('$')
  let i = 1
  while i <= last_winnr
    exec i."wincmd w"
    if &buftype == 'terminal'
      return i
    endif
    let i = i + 1
  endwhile
  return -1
endfunc

func MyWinMoveTerm()
  let winnr = MyWinFindTerm()
  if winnr != -1
    exec winnr."wincmd w"
  endif
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

func MyWinVResize(width)
  exec "vertical resize" a:width
  let w:orig_width = a:width
endfunc

func MyWinPlace(place)
  exec "wincmd " a:place
endfunc

func MyIsFullscreen()
  if &columns > 150
    return 1
  else
    return 0
  endif
endfunc

"------------------------------------------------------
" MyIDE
"------------------------------------------------------
func MyIDE()
  let l:is_fullscreen = MyIsFullscreen()
  NERDTree
  wincmd w
  MyTerm 0
  wincmd W
  if l:is_fullscreen
    "Tagbar
    vsp
  endif
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

func MyNERDTreeFileOpen(winnr)
  exec a:winnr."wincmd w"
  wincmd p
  call nerdtree#ui_glue#invokeKeyMap("<CR>")
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

func MyGV()
  GV --all
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command MyTrans                 call MyTrans()
command MyDict                  call MyDict()

command -nargs=? MyMemo         call MyMemo(<f-args>)
command -nargs=? MyHelp         call MyHelp(<f-args>)
command -nargs=1 MyMan          call MyMan(<f-args>)
command -nargs=1 MyPydoc        call MyPydoc(<f-args>)

command -nargs=0 MyWinInfo      call MyWinInfo()
command -nargs=1 MyWinResize    call MyWinResize(<f-args>)
command -nargs=1 MyWinVResize   call MyWinVResize(<f-args>)

command MyIDE                   call MyIDE()
command MyGstatusToggle         call MyGstatusToggle()
command MyNERDTreeOpen          call MyNERDTreeOpen()
command MyNERDTreeToggle        NERDTreeToggle
command MyTagbarToggle          TagbarToggle
command MyGV                    call MyGV()

"------------------------------------------------------
" command in new tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff      call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff   call MyTabDirDiff(<f-args>)
command MyTabDirDiffQuit        call MyTabDirDiffQuit()

