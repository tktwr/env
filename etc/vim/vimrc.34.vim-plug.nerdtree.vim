"------------------------------------------------------
" NERDTree
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
  call WinBufHistFindNERDTree()
  exec "NERDTreeFind" dir
endfunc

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
augroup au-nerdtree
  autocmd!
  autocmd FileType nerdtree call s:BmkNERDTreeMap()
augroup END

