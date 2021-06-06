"======================================================
" Bmk
"======================================================
if exists("g:loaded_bmk")
  finish
endif
let g:loaded_bmk = 1

let s:bmk_file = g:bmk_file
let s:bmk = {}
let s:keys = ""

"------------------------------------------------------
" private func
"------------------------------------------------------
func s:InSideBar()
  let winnr = winnr()
  if (winnr == 1 && winwidth(0) < 40)
    return 1
  else
    return 0
  endif
endfunc

func s:RemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func s:RemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
endfunc

func s:GetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

"------------------------------------------------------
" get item
"------------------------------------------------------
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

func BmkEditDirInNERDTree(url)
  1wincmd w

  let dir = BmkGetDirName(a:url)
  if dir == ""
    return
  endif

  call BmkRestoreHere()
  exec "NERDTree" dir
endfunc

func BmkEditDirInTerm(winnr, dir)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  if &buftype == 'terminal'
    exec "lcd" a:dir
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, "cd ".a:dir."\<CR>")
  endif
endfunc

func BmkEditDir(winnr, url)
  if a:winnr == 1
    call BmkEditDirInNERDTree(a:url)
  else
    call BmkEditDirInTerm(a:winnr, a:url)
  endif
endfunc

func BmkEditFile(winnr, file)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let dir = s:GetDirName(a:file)
  exec "lcd" dir
  exec "edit" a:file
endfunc

func BmkExecVimCommand(winnr, cmd)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  exec a:cmd
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

func BmkEdit(winnr, url)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "dir")
    call BmkEditDir(a:winnr, url)
  elseif (type == "file")
    call BmkEditFile(a:winnr, url)
  elseif (type == "vim_command")
    call BmkExecVimCommand(a:winnr, url[1:])
  else
    echo "BmkEdit: not supported type: [".type."]"
    return 0
  endif

  return 1
endfunc

func BmkKeyCR(winnr, url)
  let url = a:url
  let type = BmkUrlType(url)

  if (type == "http")
    call BmkOpenURL(url)
  elseif (type == "network")
    call BmkOpenDir(url)
  elseif type == "dir"
    call BmkEditDir(1, url)
  elseif type == "file"
    call BmkEditFile(a:winnr, url)
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

  call BmkEdit(a:winnr, val)
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

  call BmkKeyCR(2, val)
endfunc

"------------------------------------------------------
" this
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

  let r = BmkKeyCR(0, val)
  if !r
    call BmkOpenURL(expand('%:p'))
  endif
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:BmkMap()
  nnoremap <buffer> <C-4>   :call BmkDebug()<CR>
  nnoremap <buffer> <C-B>   :call BmkRestoreHere()<CR>
  nnoremap <buffer> <C-CR>  :call BmkOpenItem()<CR>
  nnoremap <buffer> 2       :call BmkEditItem(2)<CR>
  nnoremap <buffer> 3       :call BmkEditItem(3)<CR>
  nnoremap <buffer> 4       :call BmkEditItem(4)<CR>
  nnoremap <buffer> 5       :call BmkEditItem(5)<CR>
  nnoremap <buffer> 6       :call BmkEditItem(6)<CR>
  nnoremap <buffer> 7       :call BmkEditItem(7)<CR>
  nnoremap <buffer> 8       :call BmkEditItem(8)<CR>
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  if (s:InSideBar())
    nnoremap <buffer> <CR>    :call BmkKeyCRItem()<CR>
    nnoremap <buffer> h       :call BmkRestoreHere()<CR>
    nnoremap <buffer> l       :call BmkPreviewItem(2)<CR>
    nnoremap <buffer> k       -
    nnoremap <buffer> j       +
  else
    nnoremap <buffer> <CR>    :call BmkEditItem(0)<CR>
    if maparg('h') != ""
      nunmap <buffer> h
      nunmap <buffer> l
      nunmap <buffer> k
      nunmap <buffer> j
    endif
  endif
endfunc

"------------------------------------------------------
" load
"------------------------------------------------------
func s:BmkLoad(bmk_file)
  let bmk_file = expand(a:bmk_file)
  if !filereadable(bmk_file)
    return
  endif
  let lines = readfile(bmk_file)
  for line in lines
    if (match(line, '^\s*-') == -1)
      continue
    endif
    call s:BmkRegister(line)
  endfor
endfunc

func s:BmkRegister(line)
  let line = a:line
  let key = BmkGetItem(line, 1)
  let val = BmkGetItem(line, 2)

  let key = s:RemoveEndSpaces(key)

  let s:bmk[key] = val
  let s:keys = s:keys . key . "\n"
endfunc

func s:BmkCompleteKeys(A,L,P)
  return s:keys
endfunc

"------------------------------------------------------
" init
"------------------------------------------------------
func s:BmkInit()
  call s:BmkLoad(s:bmk_file)
endfunc

call s:BmkInit()

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
" public debug
"------------------------------------------------------
func BmkDebug()
  let val = BmkGetExpandedValueItem()
  let type = BmkUrlType(val)
  echo val
  echo type
endfunc

func BmkPrintCompleteKeys()
  echo s:keys
endfunc

"------------------------------------------------------
" public func
"------------------------------------------------------
func BmkRestoreHere()
  if !exists("w:orig_bufnr")
    let w:orig_bufnr = bufnr('%')
  endif
  exec w:orig_bufnr."b"
endfunc

func BmkHere(key)
  if !exists("w:orig_bufnr")
    let w:orig_bufnr = bufnr('%')
  endif
  exec "edit" s:bmk[a:key]
endfunc

func BmkRestore()
  1wincmd w
  call BmkRestoreHere()
endfunc

func Bmk(key)
  1wincmd w
  call BmkHere(a:key)
  call BmkSetStatusline()
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command -nargs=1 -complete=custom,s:BmkCompleteKeys Bmk      call Bmk("<args>")
command -nargs=1 -complete=custom,s:BmkCompleteKeys BmkHere  call BmkHere("<args>")
command BmkRestore      call BmkRestore()
command BmkRestoreHere  call BmkRestoreHere()

augroup bmk
  autocmd!
  autocmd FileType bmk    call s:BmkMap()
  autocmd BufWinEnter *   call s:BmkMapWin()
  autocmd WinEnter *      call s:BmkMapWin()
augroup END

