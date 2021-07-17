"======================================================
" Bmk
"======================================================
if exists("g:loaded_bmk")
  finish
endif
let g:loaded_bmk = 1

let s:bmk_winwidth = 30
let s:bmk_files = []

if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

if exists("g:bmk_files")
  let s:bmk_files = g:bmk_files
endif

"------------------------------------------------------
" private func
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
  elseif (match(url, '^//') == 0)
    let type = "network"
  elseif (match(url, '^\\') == 0)     " difficult to handle this format
    let type = ""
  elseif (match(url, '^:') == 0)
    let type = "vim_command"
  elseif (isdirectory(url))
    let type = "dir"
  elseif (filereadable(url))
    let type = "file"
  else
    let type = ""
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
func BmkEditDirInNERDTree(dir)
  call BmkSide(1)
  exec "NERDTree" a:dir
endfunc

func BmkEditDirInTerm(dir, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  if &buftype == 'terminal'
    exec "lcd" a:dir
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, "cd ".a:dir."\<CR>")
  endif
endfunc

func BmkEditDir(dir, winnr)
  if a:winnr == 1
    call BmkEditDirInNERDTree(a:dir)
  else
    call BmkEditDirInTerm(a:dir, a:winnr)
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
  if &buftype == 'terminal'
    let bufnr = winbufnr(0)
    let cmd = substitute(cmd, '<CR>', "\<CR>", '')
    call term_sendkeys(bufnr, cmd)
  else
    if (cmd[0] == ':')
      exec cmd[1:]
    else
      exec "normal ".cmd
    endif
  endif
endfunc

"------------------------------------------------------
" action
"------------------------------------------------------
func BmkOpen(url)
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
  else
    echo "BmkOpen: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

func BmkEdit(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "dir")
    call BmkEditDir(url, a:winnr)
  elseif (type == "file")
    call BmkEditFile(url, a:winnr)
  elseif (type == "vim_command")
    call BmkExecCommand(url, a:winnr)
  else
    call BmkExecCommand(url, a:winnr)
    "echo "BmkEdit: not supported type: [".type."]"
    "return 0
  endif

  return 1
endfunc

func BmkKeyCR(url, winnr)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif type == "dir"
    call BmkEditDir(url, 1)
  elseif type == "file"
    call BmkEditFile(url, a:winnr)
  elseif (type == "vim_command")
    call BmkExecCommand(url, a:winnr)
  else
    echo "BmkKeyCR: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

"------------------------------------------------------
" action on bmk item
"------------------------------------------------------
func BmkOpenItem()
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkOpen(val)
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

func BmkKeyCRItem()
  let val = BmkGetExpandedValueItem()
  if val == ""
    return
  endif

  call BmkKeyCR(val, 2)
endfunc

"------------------------------------------------------
" action on <cfile> or the current buffer
"------------------------------------------------------
func BmkOpenThis()
  let val = expand(expand("<cfile>"))

  let r = BmkOpen(val)
  if !r
    call BmkOpenFile(expand('%:p'))
  endif
endfunc

func BmkKeyCRThis()
  let val = expand(expand("<cfile>"))

  let r = BmkKeyCR(val, 0)
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
" public func
"------------------------------------------------------
" idx
"   1: the orig_bufnr
"   2-: user defined bmks
" winnr
"   0: the current window
"   1-: winnr
func BmkNr(idx, winnr)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  if !exists("w:orig_bufnr")
    let w:orig_bufnr = bufnr('%')
  endif

  let w:idx = a:idx

  if a:idx == 1
    exec w:orig_bufnr."b"
  elseif a:idx > 1
    let i = a:idx - 2
    let fname = expand(s:bmk_files[i])
    exec "edit" fname
  endif

  call BmkSetStatusline()
endfunc

func BmkHere(idx)
  call BmkNr(a:idx, 0)
endfunc

func BmkSide(idx)
  call BmkNr(a:idx, 1)
endfunc

func BmkNext()
  if !exists("w:idx")
    let w:idx = 1
  endif

  let n = len(s:bmk_files) + 1
  let idx = w:idx - 1
  let idx = (idx + 1) % n
  call BmkSide(idx + 1)
endfunc

func BmkPrev()
  if !exists("w:idx")
    let w:idx = 1
  endif

  let n = len(s:bmk_files) + 1
  let idx = w:idx - 1
  let idx = idx == 0 ? n - 1 : idx - 1
  call BmkSide(idx + 1)
endfunc

"------------------------------------------------------
" public debug
"------------------------------------------------------
func BmkDebug()
  let val = BmkGetExpandedValueItem()
  let type = BmkUrlType(val)
  "echo val
  "echo type
  echo s:bmk_files
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:BmkMap()
  nnoremap <buffer> <C-CR>  :call BmkOpenItem()<CR>
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  if (s:InSideBar())
    nnoremap <silent> <buffer> <C-N>   :silent call BmkNext()<CR>
    nnoremap <silent> <buffer> <C-P>   :silent call BmkPrev()<CR>
    nnoremap <silent> <buffer> <CR>    :call BmkKeyCRItem()<CR>
    nnoremap <silent> <buffer> h       :call BmkSide(1)<CR>
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
    nnoremap <buffer> <CR>    :call BmkEditItem(0)<CR>
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

