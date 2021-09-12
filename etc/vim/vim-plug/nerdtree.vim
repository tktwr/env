"------------------------------------------------------
" nerdtree
"------------------------------------------------------
Plug 'scrooloose/nerdtree'

let g:NERDTreeWinSize = g:my_left_winwidth
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 0
let g:NERDTreeIgnore = ['NTUSER\.', 'ntuser\.', '\.lnk$', '\.url', 'desktop\.ini']

let s:bmk_winwidth = 30
if exists("g:bmk_winwidth")
  let s:bmk_winwidth = g:bmk_winwidth
endif

"------------------------------------------------------
func MyNERDTreeOpen()
  if (&filetype == "nerdtree")
    NERDTreeToggle
  elseif (&filetype == "")
    NERDTree
  else
    "NERDTreeFind
    let l:dir = expand("%:p:h")
    exec "silent NERDTree" l:dir
  endif
endfunc

func MyNERDTreeFind(dir)
  let dir = expand(a:dir)
  call WblSelect('NERD_tree', 1)
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
func s:MyNERDTreeMap()
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

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_nerdtree
  autocmd!
  autocmd FileType nerdtree call s:MyNERDTreeMap()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command                         MyNERDTreeToggle NERDTreeToggle
command                         MyNERDTreeOpen   call MyNERDTreeOpen()
command -nargs=1 -complete=dir  MyNERDTreeFind   call MyNERDTreeFind(<f-args>)

