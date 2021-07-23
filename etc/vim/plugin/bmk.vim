"======================================================
" Bmk
"======================================================
if exists("g:loaded_bmk")
  finish
endif
let g:loaded_bmk = 1

let s:bmk_winwidth = 30

if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

"------------------------------------------------------
" util
"------------------------------------------------------
func s:InSideBar()
  let winnr = winnr()
  if (winnr == 1 && winwidth(0) <= s:bmk_winwidth)
    return 1
  else
    return 0
  endif
endfunc

func BmkRemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func BmkRemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
endfunc

func s:GetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

"------------------------------------------------------
" get item
"------------------------------------------------------
" title format per line
" [word]
func BmkGetTitle(line)
  let mx = '^\[\(.\+\)\].*'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\1', '')
  return item
endfunc

" item format per line
" - word word    | word
func BmkGetItem(line, idx)
  let mx = '- \(.\+\)\s*|\s*\(.\+\)'
  let line = a:line
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\'.a:idx, '')
  return item
endfunc

func BmkGetKeyItem()
  let line = getline('.')
  return BmkGetItem(line, 1)
endfunc

func BmkGetValueItem()
  let line = getline('.')
  return BmkGetItem(line, 2)
endfunc

func BmkGetExpandedValueItem()
  let line = getline('.')
  return expand(BmkGetItem(line, 2))
endfunc

func BmkUrlType(url)
  let url = a:url

  if (match(url, 'http\|https') == 0)
    let type = "http"
  elseif (match(url, '\.html$') != -1)
    let type = "html"
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
    let dir = s:GetDirName(val)
  elseif type == "html"
    let dir = s:GetDirName(val)
  else
    let dir = ""
  endif

  return dir
endfunc

func s:BmkPrintItem()
  let key = BmkGetKeyItem()
  let key = BmkRemoveEndSpaces(key)
  if (len(key) > s:bmk_winwidth / 2)
    echo key
  else
    echo ""
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

func BmkEditFile(file, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let dir = s:GetDirName(a:file)
  exec "lcd" dir
  exec "edit" a:file
endfunc

func BmkExecCommand(cmd, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let cmd = a:cmd
  let cmd = substitute(cmd, '<CR>', "\<CR>", '')
  let cmd = substitute(cmd, '_Plug_', '\\<Plug>', '')
  if (match(cmd, 'Plug') != -1)
    let cmd = '"'.cmd.'"'
  endif

  if &buftype == 'terminal'
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, cmd)
  else
    if (cmd[0] == ':')
      exec cmd[1:]
    else
      echo "normal ".cmd
      exec "normal ".cmd
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
  elseif type == "html"
    call BmkOpenFile(url)
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
  elseif type == "html"
    call BmkEditFile(url, a:winnr)
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

func BmkView(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif type == "dir"
    call BmkEditDir(url, a:winnr)
  elseif type == "file"
    call BmkEditFile(url, a:winnr)
  elseif type == "html"
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

func BmkEditItem(winnr)
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkEdit(val, a:winnr)
endfunc

func BmkPreviewItem(winnr)
  call BmkEditItem(a:winnr)
  wincmd p
endfunc

func BmkViewItem(winnr)
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkView(val, a:winnr)
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
" statusline
"------------------------------------------------------
func BmkStatuslineWinNr()
  let winnr = winnr()
  return '['.winnr.']'
endfunc

func BmkStatusline()
  let stat = "%{BmkStatuslineWinNr()}"
  let stat.= "\ %t"
  return stat
endfunc

func BmkSetStatusline()
  setl statusline=%!BmkStatusline()
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:BmkMap()
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  if (s:InSideBar())
    nnoremap <silent> <buffer> <C-CR>  :call BmkOpenItem(2)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call BmkViewItem(2)<CR>
    nnoremap <silent> <buffer> <CR>    :call BmkEditItem(2)<CR>
    nnoremap <silent> <buffer> h       :call WinBufHistFindNERDTree()<CR>
    nnoremap <silent> <buffer> l       :call BmkPreviewItem(2)<CR>
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
    nnoremap <silent> <buffer> <C-CR>  :call BmkOpenItem(0)<CR>
    nnoremap <silent> <buffer> <S-CR>  :call BmkViewItem(0)<CR>
    nnoremap <silent> <buffer> <CR>    :call BmkEditItem(0)<CR>
    if maparg('h') != ""
      nunmap <buffer> h
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
" nerdtree
"------------------------------------------------------
func BmkNERDTreeSelected()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        return n.path.str()
    endif
    return ""
endfunc

func BmkNERDTreeEdit(winnr)
  let selected = BmkNERDTreeSelected()

  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

func BmkNERDTreePreview(winnr)
  call BmkNERDTreeEdit(a:winnr)
  wincmd p
endfunc

func BmkNERDTreePrintItem()
  let key = BmkNERDTreeSelected()
  if (len(key) > s:bmk_winwidth / 2)
    echo key
  else
    echo ""
  endif
endfunc

func BmkNERDTreePrevItem()
  normal -
  call BmkNERDTreePrintItem()
endfunc

func BmkNERDTreeNextItem()
  normal +
  call BmkNERDTreePrintItem()
endfunc

func s:BmkNERDTreeMap()
  nmap <buffer> k       :call BmkNERDTreePrevItem()<CR>
  nmap <buffer> j       :call BmkNERDTreeNextItem()<CR>
  nmap <buffer> h       u
  nmap <buffer> l       :call BmkNERDTreePreview(2)<CR>
  nmap <buffer> 2       :call BmkNERDTreeEdit(2)<CR>
  nmap <buffer> 3       :call BmkNERDTreeEdit(3)<CR>
  nmap <buffer> 4       :call BmkNERDTreeEdit(4)<CR>
  nmap <buffer> 5       :call BmkNERDTreeEdit(5)<CR>
  nmap <buffer> 6       :call BmkNERDTreeEdit(6)<CR>
  nmap <buffer> 7       :call BmkNERDTreeEdit(7)<CR>
  nmap <buffer> 8       :call BmkNERDTreeEdit(8)<CR>
  nmap <buffer> 9       :call BmkNERDTreeEdit(9)<CR>
endfunc

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup bmk
  autocmd!
  autocmd FileType nerdtree call s:BmkNERDTreeMap()
  autocmd FileType bmk      call s:BmkMap()
  autocmd BufWinEnter *     call s:BmkMapWin()
  autocmd WinEnter *        call s:BmkMapWin()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=+ BmkEditFile  call BmkEditFile(<f-args>)

func BmkDebug()
  let key = BmkGetKeyItem()
  let val = BmkGetExpandedValueItem()
  let type = BmkUrlType(val)
  echo key.", ".val.", ".type
endfunc

