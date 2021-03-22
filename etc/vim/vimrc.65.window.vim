"======================================================
" window
"======================================================
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

func MyTerm(type)
  if a:type == 0
    let l:is_fullscreen = MyIsFullscreen()
    if l:is_fullscreen
      exec "below term ++rows=".g:my_term_winheight
    else
      exec "bot term ++rows=".g:my_term_winheight
    endif
    set winfixheight
  elseif a:type == 1
    tabedit
    bot term
    only
  elseif a:type == 2
    tabedit
    bot term
    only
    bot term
  endif
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

func MyNERDTreeT2E(dir)
  exec "NERDTree" a:dir

  let l:is_fullscreen = MyIsFullscreen()
  if !l:is_fullscreen
    exec "wincmd p"
    call MyWinPlace("J")
    exec "wincmd p"
  endif
endfunc

func MyEditT2E(file)
  exec "wincmd p"
  exec "edit" a:file
endfunc

func MySplitT2E(file)
  exec "wincmd p"
  exec "split" a:file
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=1 MyNERDTreeT2E  call MyNERDTreeT2E("<args>")
command -nargs=1 MyEditT2E      call MyEditT2E("<args>")
command -nargs=1 MySplitT2E     call MySplitT2E("<args>")
command -nargs=1 MyWinResize    call MyWinResize("<args>")
command -nargs=1 MyTerm         call MyTerm("<args>")

command MyNERDTreeToggle call MyNERDTreeToggle()
command MyGstatusToggle  call MyGstatusToggle()
command MyTagbarToggle   TagbarToggle

command MyTabGstatus     tabedit +MyGstatusToggle
command MyTabGV          GV --all

