"======================================================
" nerdtree
"======================================================

let s:bmk_winwidth = 30
if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

"------------------------------------------------------

func MyNERDTreeToggle()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    MyNERDTreeFind("%:p:h")
  endif
endfunc

func MyNERDTreeFind(dir)
  let dir = expand(a:dir)
  call WblFind('NERD_tree', 1)
  exec "NERDTreeFind" dir
endfunc

"------------------------------------------------------
func MyNERDTreeSelected()
  let n = g:NERDTreeFileNode.GetSelected()
  if n != {}
    return n.path.str()
  endif
  return ""
endfunc

func MyNERDTreeEditItem(winnr)
  let selected = MyNERDTreeSelected()
  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

func MyNERDTreePreviewItem(winnr)
  let prev_winnr = winnr()
  call MyNERDTreeEditItem(a:winnr)
  exec prev_winnr."wincmd w"
endfunc

"------------------------------------------------------
func MyNERDTreePrintItem()
  let key = MyNERDTreeSelected()
  if (len(key) > s:bmk_winwidth / 2)
    echo key
  else
    echo ""
  endif
endfunc

func MyNERDTreePrevItem()
  normal -
  call MyNERDTreePrintItem()
endfunc

func MyNERDTreeNextItem()
  normal +
  call MyNERDTreePrintItem()
endfunc

"------------------------------------------------------
func MyNERDTreeMap()
  nmap <buffer> h       u
  nmap <buffer> l       :call MyNERDTreePreviewItem(-2)<CR>
  nmap <buffer> j       :call MyNERDTreeNextItem()<CR>
  nmap <buffer> k       :call MyNERDTreePrevItem()<CR>

  nmap <buffer> 2       :call MyNERDTreeEditItem(2)<CR>
  nmap <buffer> 3       :call MyNERDTreeEditItem(3)<CR>
  nmap <buffer> 4       :call MyNERDTreeEditItem(4)<CR>
  nmap <buffer> 5       :call MyNERDTreeEditItem(5)<CR>
  nmap <buffer> 6       :call MyNERDTreeEditItem(6)<CR>
  nmap <buffer> 7       :call MyNERDTreeEditItem(7)<CR>
  nmap <buffer> 8       :call MyNERDTreeEditItem(8)<CR>
  nmap <buffer> 9       :call MyNERDTreeEditItem(9)<CR>

  nmap <buffer> B       :Bookmark<CR>
  nmap <buffer> E       :EditBookmarks<CR>
  "nmap <buffer> D       :echo D<CR>  "delete bookmark

  "nmap <buffer> <Space> goq
  nmap <buffer> <C-J>   <C-W>w
  nmap <buffer> <C-K>   <C-W>W
  nmap <buffer> <C-.>   C
endfunc

