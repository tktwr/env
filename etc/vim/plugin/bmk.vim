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
" get item
"------------------------------------------------------
func BmkGetKeyHere()
  return BmkGetItemHere(1)
endfunc

func BmkGetValueHere()
  return BmkGetItemHere(2)
endfunc

func BmkGetItemHere(idx)
  let mx = '- \(.\+\)\s*|\s*\(.\+\)'
  let line = getline('.')
  let line = matchstr(line, mx)
  let item = substitute(line, mx, '\'.a:idx, '')
  return item
endfunc

"------------------------------------------------------
" load
"------------------------------------------------------
func s:BmkRegister(line)
  let result = MyGetKeyFname(a:line)
  let key = result["key"]
  let fname = result["fname"]
  let s:bmk[key] = fname
  let s:keys = s:keys . key . "\n"
endfunc

func s:BmkLoad()
  let bmk_file = expand(s:bmk_file)
  if !filereadable(bmk_file)
    return
  endif
  let lines = readfile(bmk_file)
  for line in lines
    let line = MyCleanLine(line)
    if line == "" || line[0] == '#' || line[0] == '['
      continue
    endif
    call s:BmkRegister(line)
  endfor
endfunc

"------------------------------------------------------
" action
"------------------------------------------------------
func BmkOpen()
  let val = BmkGetValueHere()
  if val == ""
    return
  endif

  call MyOpen(val)
endfunc

func BmkOpenDirInNERDTree()
  let val = BmkGetValueHere()
  if val == ""
    return
  endif

  let dir = MyExpandDir(val)
  call BmkRestore()
  exec "NERDTree" dir
endfunc

func BmkEditFileInWin(winnr)
  let val = BmkGetValueHere()
  if val == ""
    return
  endif

  call MyEdit(a:winnr, val)
endfunc

func BmkPreviewFileInWin(winnr)
  let val = BmkGetValueHere()
  if val == ""
    return
  endif

  call MyEdit(a:winnr, val)
  wincmd p
endfunc

func BmkKeyCR()
  let val = BmkGetValueHere()
  if val == ""
    return
  endif

  let r = MyExpand(val)
  let type = r["type"]
  let url = r["url"]

  if type == "dir"
    call BmkOpenDirInNERDTree()
  elseif (type == "http")
    call MyOpenURL(url)
  else
    call BmkEditFileInWin(2)
  endif
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func s:BmkMap()
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

  let winnr = winnr()
  if (winnr == 1 && winwidth(0) == g:NERDTreeWinSize)
    nnoremap <buffer> <CR>    :call BmkKeyCR()<CR>
    nnoremap <buffer> k       -
    nnoremap <buffer> j       +
    nnoremap <buffer> h       :call BmkRestore()<CR>
    nnoremap <buffer> l       :call BmkPreviewFileInWin(2)<CR>
  else
    nnoremap <buffer> <CR>    :call BmkEditFileInWin(0)<CR>
    if maparg('h') != ""
      nunmap <buffer> k
      nunmap <buffer> j
      nunmap <buffer> h
      nunmap <buffer> l
    endif
  endif
endfunc

"------------------------------------------------------
" init
"------------------------------------------------------
func s:BmkInit()
  call s:BmkLoad()
endfunc

call s:BmkInit()

"------------------------------------------------------
" statusline
"------------------------------------------------------
func BmkStatusline()
  let l:statusline = "%{MyStatuslineWinNr()}"
  let l:statusline.= "%t"
  return l:statusline
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

func BmkRestore()
  1wincmd w
  call BmkRestoreHere()
endfunc

func BmkHere(key)
  if !exists("w:orig_bufnr")
    let w:orig_bufnr = bufnr('%')
  endif
  exec "edit" s:bmk[a:key]
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

