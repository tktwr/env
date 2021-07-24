"------------------------------------------------------
" fern
"------------------------------------------------------
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

let g:fern#drawer_width = g:my_left_winwidth
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'

"------------------------------------------------------
func MyFernToggle()
  let cmd = printf("Fern . -reveal=%% -drawer -toggle")
  exec cmd
endfunc

func MyFern(dir)
  let dir = expand(a:dir)
  let cmd = printf("Fern %s -reveal=%% -drawer", dir)
  exec cmd
endfunc

"------------------------------------------------------
func MyFernSelected()
  exec "normal \<Plug>(fern-action-yank)"
  return getreg(v:register)
endfunc

func MyFernEdit(winnr)
  let selected = MyFernSelected()

  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

func MyFernPreview(winnr)
  let prev_winnr = winnr()
  if a:winnr > 0
    exec a:winnr."wincmd w"
    wincmd p
  endif

  exec "normal \<Plug>(fern-my-edit-expand-collapse)"

  let curr_winnr = winnr()
  if curr_winnr != prev_winnr
    exec "lcd" expand('%:p:h')
    wincmd p
  endif
endfunc

"------------------------------------------------------
function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-select-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer><expr>
        \ <Plug>(fern-my-edit-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:edit)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-select-expand-collapse)
  nmap <buffer> <CR>  <Plug>(fern-my-select-expand-collapse)

  nmap <buffer> N     <Plug>(fern-action-new-path)
  nmap <buffer> D     <Plug>(fern-action-remove)
  nmap <buffer> M     <Plug>(fern-action-move)
  nmap <buffer> R     <Plug>(fern-action-rename)

  nmap <buffer> <C-G> <Plug>(fern-action-reload)
  nmap <buffer> ?     <Plug>(fern-action-help)
  nmap <buffer> !     <Plug>(fern-action-hidden)
  nmap <buffer> m     <Plug>(fern-action-mark)
  nmap <buffer> s     <Plug>(fern-action-open:split)
  nmap <buffer> v     <Plug>(fern-action-open:vsplit)

  nmap <buffer> h     <Plug>(fern-action-collapse)
  "nmap <buffer> l     <Plug>(fern-my-edit-expand-collapse)
  nmap <buffer> l     :call MyFernPreview(2)<CR>
  nmap <buffer> j     +
  nmap <buffer> k     -

  nmap <buffer> 2     :call MyFernEdit(2)<CR>
  nmap <buffer> 3     :call MyFernEdit(3)<CR>
  nmap <buffer> 4     :call MyFernEdit(4)<CR>
  nmap <buffer> 5     :call MyFernEdit(5)<CR>
  nmap <buffer> 6     :call MyFernEdit(6)<CR>
  nmap <buffer> 7     :call MyFernEdit(7)<CR>
  nmap <buffer> 8     :call MyFernEdit(8)<CR>
  nmap <buffer> 9     :call MyFernEdit(9)<CR>

  nmap <buffer> <Space> :call MyMenuPopupMenu(2)<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup au-fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command                         MyFernToggle     call MyFernToggle()
command -nargs=1 -complete=dir  MyFern           call MyFern(<f-args>)

