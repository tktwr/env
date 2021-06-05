"======================================================
" Bmk
"======================================================
if exists("loaded_bmk")
  finish
endif
let loaded_bmk = 1

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

func BmkGetKeyHere()
  let line = getline('.')
  return BmkGetItem(line, 1)
endfunc

func BmkGetValueHere()
  let line = getline('.')
  return BmkGetItem(line, 2)
endfunc

func BmkGetExpandedValueHere()
  let line = getline('.')
  return expand(BmkGetItem(line, 2))
endfunc

"------------------------------------------------------
" load
"------------------------------------------------------
func s:BmkRegister(line)
  let line = a:line
  let key = BmkGetItem(line, 1)
  let val = BmkGetItem(line, 2)

  let key = s:RemoveEndSpaces(key)

  let s:bmk[key] = val
  let s:keys = s:keys . key . "\n"
endfunc

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

"------------------------------------------------------
" action
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

func BmkOpen()
  let val = BmkGetExpandedValueHere()
  if val == ""
    return
  endif

  call MyOpen(val)
endfunc

func BmkOpenDirInNERDTree()
  let val = BmkGetExpandedValueHere()
  if val == ""
    return
  endif

  let dir = BmkGetDirName(val)
  if dir == ""
    return
  endif

  call BmkRestore()
  exec "NERDTree" dir
endfunc

func BmkEditFileInWin(winnr)
  let val = BmkGetExpandedValueHere()
  if val == ""
    return
  endif

  let type = BmkUrlType(val)

  if (type == "vim_command")
    call MyExecVimCommand(a:winnr, val[1:])
  else
    call MyEdit(a:winnr, val)
  endif
endfunc

func BmkPreviewFileInWin(winnr)
  call BmkEditFileInWin(a:winnr)
  wincmd p
endfunc

func BmkKeyCR()
  let val = BmkGetExpandedValueHere()
  if val == ""
    return
  endif

  let type = BmkUrlType(val)

  if (type == "http")
    call MyOpenURL(val)
  elseif (type == "network")
    call MyOpenDir(val)
  elseif type == "dir"
    call BmkOpenDirInNERDTree()
  elseif type == "file"
    call BmkEditFileInWin(2)
  else
    echo "BmkKeyCR: not supported type: [".type."]"
  endif
endfunc

func BmkDebug()
  let val = BmkGetExpandedValueHere()
  let type = BmkUrlType(val)
  echo val
  echo type
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:BmkMap()
  nnoremap <buffer> <C-4>   :call BmkDebug()<CR>
  nnoremap <buffer> <C-B>   :call BmkRestoreHere()<CR>
  nnoremap <buffer> <C-CR>  :call BmkOpen()<CR>
  nnoremap <buffer> 2       :call BmkEditFileInWin(2)<CR>
  nnoremap <buffer> 3       :call BmkEditFileInWin(3)<CR>
  nnoremap <buffer> 4       :call BmkEditFileInWin(4)<CR>
  nnoremap <buffer> 5       :call BmkEditFileInWin(5)<CR>
  nnoremap <buffer> 6       :call BmkEditFileInWin(6)<CR>
  nnoremap <buffer> 7       :call BmkEditFileInWin(7)<CR>
  nnoremap <buffer> 8       :call BmkEditFileInWin(8)<CR>
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  if (s:InSideBar())
    nnoremap <buffer> <CR>    :call BmkKeyCR()<CR>
    nnoremap <buffer> h       :call BmkRestore()<CR>
    nnoremap <buffer> l       :call BmkPreviewFileInWin(2)<CR>
    nnoremap <buffer> k       -
    nnoremap <buffer> j       +
  else
    nnoremap <buffer> <CR>    :call BmkEditFileInWin(0)<CR>
    if maparg('h') != ""
      nunmap <buffer> h
      nunmap <buffer> l
      nunmap <buffer> k
      nunmap <buffer> j
    endif
  endif
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
func BmkStatusline()
  let stat = "%{MyStatuslineWinNr()}"
  let stat.= "\ %t"
  return stat
endfunc

func BmkSetStatusline()
  setl statusline=%!BmkStatusline()
endfunc

"------------------------------------------------------
" public func
"------------------------------------------------------
func BmkPrintCompleteKeys()
  echo s:keys
endfunc

func s:BmkCompleteKeys(A,L,P)
  return s:keys
endfunc

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

