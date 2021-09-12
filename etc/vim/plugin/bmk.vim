"======================================================
" Bmk
"======================================================
if exists("g:loaded_bmk")
  finish
endif
let g:loaded_bmk = 1

"------------------------------------------------------
" set global variables
"------------------------------------------------------
func s:SetGlobalVars()
  " set defaults
  let s:bmk_debug = 0
  let s:bmk_winwidth = 30

  " set global variables
  if exists("g:bmk_winwidth")
    let s:bmk_winwidth = g:bmk_winwidth
  endif
endfunc

"------------------------------------------------------
" type
"------------------------------------------------------
func BmkUrlType(url)
  let url = a:url

  if (match(url, 'http\|https') == 0)
    let type = "http"
  elseif (match(url, '\.html$') != -1)
    let type = "html"
  elseif (match(url, '\.pdf$') != -1)
    let type = "pdf"
  elseif (match(url, '^//') == 0)
    let type = "network"
  elseif (match(url, '^\\') == 0)     " difficult to handle this format
    let type = "network"
  elseif (match(url, '^:') == 0)
    let type = "vim_command"
  elseif (isdirectory(url))
    let type = "dir"
  elseif (filereadable(url))
    let type = "file"
  else
    let type = "term_command"
  endif

  return type
endfunc

func BmkGetDirName(val)
  let val = a:val
  let type = BmkUrlType(val)

  if type == "dir"
    let dir = val
  elseif type == "file"
    let dir = TtGetDirName(val)
  elseif type == "html"
    let dir = TtGetDirName(val)
  else
    let dir = ""
  endif

  return dir
endfunc

"------------------------------------------------------
" get item
"------------------------------------------------------
" bmk format
"   [title] str
"   space [-+] shortcut key    | val

" return "title"
func BmkGetTitle(line)
  let mx = '^\[\(.\+\)\].*'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\1', '')
  return item
endfunc

" return indexed item
func BmkGetItem(line, idx)
  let mx = '[-+] \(.\+\)\s*|\s*\(.\+\)'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\'.a:idx, '')
  let item = TtRemoveEndSpaces(item)
  return item
endfunc

" return "shortcut key"
func BmkGetKeyItem()
  let line = getline('.')
  return BmkGetItem(line, 1)
endfunc

" return "val"
func BmkGetValueItem()
  let line = getline('.')
  return BmkGetItem(line, 2)
endfunc

func BmkGetExpandedValueItem()
  let line = getline('.')
  return expand(BmkGetItem(line, 2))
endfunc

"------------------------------------------------------
" print item
"------------------------------------------------------
func s:BmkPrintItem()
  if s:bmk_debug
    let key = BmkGetKeyItem()
    let val = BmkGetExpandedValueItem()
    let type = BmkUrlType(val)
    echo "key=[".key."], val=[".val."], type=[".type."]"
  else
    let key = BmkGetKeyItem()
    if (len(key) > s:bmk_winwidth / 2)
      echo key
    else
      echo ""
    endif
  endif
endfunc

func s:BmkPrevItem()
  normal -
  call s:BmkPrintItem()
endfunc

func s:BmkNextItem()
  normal +
  call s:BmkPrintItem()
endfunc

"------------------------------------------------------
" external open
"------------------------------------------------------
func BmkOpenURL(url)
  exec "silent !chrome.sh" a:url
  redraw!
endfunc

func BmkOpenDir(url)
  exec "silent !explorer.sh" a:url
  redraw!
endfunc

func BmkOpenFile(url)
  exec "silent !vscode.sh" a:url
  redraw!
endfunc

"------------------------------------------------------
" internal open
"------------------------------------------------------
func BmkEditDirInTerm(dir, winnr)
  if &buftype == 'terminal'
    exec "lcd" a:dir
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, "cd ".a:dir."\<CR>")
  endif
endfunc

func BmkEditDir(dir, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  if &buftype == 'terminal'
    call BmkEditDirInTerm(a:dir, a:winnr)
  else
    "call MyNERDTreeFind(a:dir)
    call MyFern(a:dir)
  endif
endfunc

" winnr == -2: the first editor window
" winnr == -1: the last editor window
" winnr ==  0: the current window
" winnr >=  1: the specified window
func BmkEditFile(file, winnr)
  let winnr = a:winnr
  if winnr == -2
    let winnr = TtFindFirstEditor()
  elseif winnr == -1
    let winnr = TtFindLastEditor()
  endif
  if winnr > 0
    exec winnr."wincmd w"
  endif

  let dir = TtGetDirName(a:file)
  if &buftype == 'terminal'
    call BmkEditDirInTerm(dir, winnr)
  else
    exec "lcd" dir
    exec "edit" a:file
  endif
endfunc

func BmkEditPDF(file, winnr)
  let winnr = a:winnr
  if winnr == -2
    let winnr = TtFindFirstEditor()
  elseif winnr == -1
    let winnr = TtFindLastEditor()
  endif
  if winnr > 0
    exec winnr."wincmd w"
  endif

  let dir = TtGetDirName(a:file)
  if &buftype == 'terminal'
    call BmkEditDirInTerm(dir, winnr)
  else
    exec "lcd" dir
    let cmd = printf("pdftotext %s -", a:file)
    let out = system(cmd)
    let cmd = printf("edit %s.txt", a:file)
    exec cmd
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal buflisted
    setlocal noswapfile
    call TtPut0(out)
    normal 1G
  endif
endfunc

func BmkExecCommand(cmd, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let cmd = a:cmd
  let cmd = substitute(cmd, '<CR>', "\<CR>", '')
  let cmd = substitute(cmd, '_Plug_', "\<Plug>", '')

  if &buftype == 'terminal'
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, cmd)
  else
    if (cmd[0] == ':')
      exec cmd[1:]
    else
      call feedkeys(cmd)
    endif
  endif
endfunc

"------------------------------------------------------
" action
"------------------------------------------------------
func BmkOpen(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif (type == "dir")
    call BmkOpenDir(url)
  elseif (type == "file")
    call BmkOpenFile(url)
  elseif (type == "html")
    call BmkOpenFile(url)
  elseif (type == "pdf")
    call BmkOpenURL(url)
  elseif (type == "vim_command")
    call BmkExecCommand(url, a:winnr)
  elseif (type == "term_command")
    call BmkExecCommand(url, a:winnr)
  else
    echo "BmkOpen: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

func BmkView(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif (type == "dir")
    call BmkEditDir(url, a:winnr)
  elseif (type == "file")
    call BmkEditFile(url, a:winnr)
  elseif (type == "html")
    call BmkOpenURL(url)
  elseif (type == "pdf")
    call BmkOpenURL(url)
  elseif (type == "vim_command")
    call BmkExecCommand(url, a:winnr)
  elseif (type == "term_command")
    call BmkExecCommand(url, a:winnr)
  else
    echo "BmkView: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

func BmkEdit(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif (type == "dir")
    call BmkEditDir(url, a:winnr)
  elseif (type == "file")
    call BmkEditFile(url, a:winnr)
  elseif (type == "html")
    call BmkEditFile(url, a:winnr)
  elseif (type == "pdf")
    call BmkEditPDF(url, a:winnr)
  elseif (type == "vim_command")
    call BmkExecCommand(url, a:winnr)
  elseif (type == "term_command")
    call BmkExecCommand(url, a:winnr)
  else
    echo "BmkEdit: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

"------------------------------------------------------
" action on bmk item
"------------------------------------------------------
func BmkOpenItem(winnr)
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkOpen(val, a:winnr)
endfunc

func BmkViewItem(winnr)
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkView(val, a:winnr)
endfunc

func BmkEditItem(winnr)
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkEdit(val, a:winnr)
endfunc

func BmkPreviewItem(winnr)
  let prev_winnr = winnr()
  call BmkEditItem(a:winnr)
  exec prev_winnr."wincmd w"
endfunc

"------------------------------------------------------
" action on <cfile> or the current buffer
"------------------------------------------------------
func BmkOpenThis()
  let val = expand(expand("<cfile>"))

  let r = BmkOpen(val, 0)
  if !r
    call BmkOpenFile(expand('%:p'))
  endif
endfunc

func BmkViewThis()
  let val = expand(expand("<cfile>"))

  let r = BmkView(val, 0)
  if !r
    call BmkOpenURL(expand('%:p'))
  endif
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:init_bmk()
  call TtSetStatusline()
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  if (TtInSideBar())
    nnoremap <silent> <buffer> <CR>    :call BmkEditItem(-2)<CR>
    nnoremap <silent> <buffer> <C-CR>  :call BmkViewItem(-2)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call BmkOpenItem(-2)<CR>
    nnoremap <silent> <buffer> l       :call BmkPreviewItem(-2)<CR>
    nnoremap <silent> <buffer> k       :call <SID>BmkPrevItem()<CR>
    nnoremap <silent> <buffer> j       :call <SID>BmkNextItem()<CR>
    nnoremap <silent> <buffer> 2       :call BmkEditItem(2)<CR>
    nnoremap <silent> <buffer> 3       :call BmkEditItem(3)<CR>
    nnoremap <silent> <buffer> 4       :call BmkEditItem(4)<CR>
    nnoremap <silent> <buffer> 5       :call BmkEditItem(5)<CR>
    nnoremap <silent> <buffer> 6       :call BmkEditItem(6)<CR>
    nnoremap <silent> <buffer> 7       :call BmkEditItem(7)<CR>
    nnoremap <silent> <buffer> 8       :call BmkEditItem(8)<CR>
    nnoremap <silent> <buffer> 9       :call BmkEditItem(9)<CR>
  else
    nnoremap <silent> <buffer> <CR>    :call BmkEditItem(0)<CR>
    nnoremap <silent> <buffer> <C-CR>  :call BmkViewItem(0)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call BmkOpenItem(0)<CR>
    if maparg('l') != ""
      nunmap <buffer> l
      nunmap <buffer> k
      nunmap <buffer> j
      nunmap <buffer> 2
      nunmap <buffer> 3
      nunmap <buffer> 4
      nunmap <buffer> 5
      nunmap <buffer> 6
      nunmap <buffer> 7
      nunmap <buffer> 8
      nunmap <buffer> 9
    endif
  endif
endfunc

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_bmk
  autocmd!
  autocmd FileType bmk      call s:init_bmk()
  autocmd BufWinEnter *     call s:BmkMapWin()
  autocmd WinEnter *        call s:BmkMapWin()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=+ BmkEditFile  call BmkEditFile(<f-args>)

func BmkToggleDebug()
  let s:bmk_debug = !s:bmk_debug
endfunc

"------------------------------------------------------
" init
"------------------------------------------------------
func s:Init()
  call s:SetGlobalVars()
endfunc

call s:Init()

