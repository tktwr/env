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
    let result = MyGetKeyFname(line)
    let key = result["key"]
    let fname = result["fname"]
    let s:bmk[key] = fname
    let s:keys = s:keys . key . "\n"
  endfor
endfunc

func BmkOpen()
  let result = MyGetKeyFnameHere()
  call MyOpen(result["fname"])
endfunc

func BmkOpenDirInNERDTree()
  let result = MyGetKeyFnameHere()
  let dir = MyExpandDir(result["fname"])
  b#
  exec "NERDTree" dir
endfunc

func BmkEditFileInWin(winnr)
  let result = MyGetKeyFnameHere()
  call MyEdit(a:winnr, result["fname"])
endfunc

func BmkPreviewFileInWin(winnr)
  call BmkEditFileInWin(a:winnr)
  wincmd p
endfunc

func BmkKeyCR()
  let result = MyGetKeyFnameHere()
  let key = result["key"]
  let fname = result["fname"]

  let result = MyExpand(fname)
  let type = result["type"]
  let url = result["url"]

  if type == "dir"
    call BmkOpenDirInNERDTree()
  else
    call BmkEditFileInWin(2)
  endif
endfunc

func s:BmkMap()
  nnoremap <buffer> <C-B>   :b#<CR>
  nnoremap <buffer> <C-CR>  :call BmkOpen()<CR>
  nnoremap <buffer> 2       :call BmkEditFileInWin(2)<CR>
  nnoremap <buffer> 3       :call BmkEditFileInWin(3)<CR>
  nnoremap <buffer> 4       :call BmkEditFileInWin(4)<CR>
  nnoremap <buffer> 5       :call BmkEditFileInWin(5)<CR>
endfunc

func s:BmkMapWin()
  if &filetype != "bmk"
    return
  endif

  let winnr = winnr()
  if winnr == 1
    nnoremap <buffer> <CR>    :call BmkKeyCR()<CR>
    nnoremap <buffer> k       -
    nnoremap <buffer> j       +
    nnoremap <buffer> h       :b#<CR>
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
" public func
"------------------------------------------------------
func BmkPrintCompleteKeys()
  echo s:keys
endfunc

func s:BmkCompleteKeys(A,L,P)
  return s:keys
endfunc

func s:Bmk(key)
  exec "edit" s:bmk[a:key]
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command -nargs=1 -complete=custom,s:BmkCompleteKeys Bmk  call s:Bmk("<args>")

autocmd FileType bmk    call s:BmkMap()
autocmd BufWinEnter *   call s:BmkMapWin()
autocmd WinEnter *      call s:BmkMapWin()

