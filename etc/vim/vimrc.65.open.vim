"------------------------------------------------------
" open.func
"------------------------------------------------------
func MyOpenURL(url)
  exec "silent !chrome.sh" a:url
  redraw!
endfunc

func MyOpenDir(url)
  exec "silent !explorer.sh" a:url
  redraw!
endfunc

func MyOpen(url)
  let l:result = MyExpand(a:url)

  if (l:result["type"] == "http")
    call MyOpenURL(l:result["url"])
  elseif (l:result["type"] == "dir")
    call MyOpenDir(l:result["url"])
  elseif (l:result["type"] == "file")
    call MyOpenURL(l:result["url"])
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
" Term
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

" recieve a dir from a terminal
func Tapi_NERDTree(_, dir)
  exec "NERDTree" a:dir
  exec "wincmd p"
  call MyWinPlace("J", g:my_term_winheight)
  exec "wincmd p"
endfunc

func Tapi_Edit(_, file)
  exec "wincmd p"
  exec "edit" a:file
endfunc

func s:MyTerm(type)
  if a:type == 0
    exec "bot term ++rows=".g:my_term_winheight
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

let g:win_layout = ""

func MyWinResize(height)
  exec "resize" a:height
  let g:win_layout = ""
endfunc

func MyWinPlace(place, height)
  exec "wincmd " a:place
  exec "resize" a:height
  let g:win_layout = ""
endfunc

func MyWinMaximizeToggle()
  if (g:win_layout == "")
    let g:win_layout = winrestcmd()
    exec "resize"
    exec "vertical resize"
  else
    exec g:win_layout
    let g:win_layout = ""
  endif
endfunc

"------------------------------------------------------
" open.command
"------------------------------------------------------
command MyNERDTreeToggle call MyNERDTreeToggle()
command MyGstatusToggle  call MyGstatusToggle()

command -nargs=1 MyTerm  call s:MyTerm("<args>")

