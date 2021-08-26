"------------------------------------------------------
" fern
"------------------------------------------------------
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

if $MY_PROMPT_TYPE >= 4
  Plug 'lambdalisue/fern-git-status.vim'
endif

let g:fern#drawer_width = g:my_left_winwidth
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'
"let g:fern#renderer#default#leading = "  "

"------------------------------------------------------
func MyFernDrawerToggle()
  "let cmd = printf("Fern . -reveal=%% -drawer -width=%d -toggle", g:fern#drawer_width)
  let cmd = printf("Fern . -reveal=%% -drawer -toggle")
  exec cmd
endfunc

func MyFernDrawer(dir)
  let dir = expand(a:dir)
  "let cmd = printf("Fern %s -reveal=%% -drawer -width=%d", dir, g:fern#drawer_width)
  let cmd = printf("Fern %s -reveal=%% -drawer", dir)
  exec cmd
endfunc

func MyFern(dir)
  let dir = expand(a:dir)
  let cmd = printf("Fern %s -reveal=%%", dir)
  exec cmd
endfunc

"------------------------------------------------------
func MyFernSelected()
  let helper = fern#helper#new()
  let node = helper.sync.get_cursor_node()
  return node._path
endfunc

func MyFernEdit(winnr)
  let selected = MyFernSelected()

  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

func MyFernFindFirstEditor()
  let last_winnr = winnr('$')
  let i = 1
  while i <= last_winnr
    exec i."wincmd w"
    if &filetype != 'fern'
      return i
    endif
    let i = i + 1
  endwhile
  return -1
endfunc

func MyFernPreviewInFirstEditor()
  let prev_winnr = winnr()
  let winnr = MyFernFindFirstEditor()
  exec prev_winnr."wincmd w"
  if winnr == -1
    return
  endif
  call MyFernPreview(winnr)
endfunc

func MyFernPreview(winnr)
  let prev_winnr = winnr()
  if a:winnr > 0
    exec a:winnr."wincmd w"
    wincmd p
  endif

  let selected = MyFernSelected()
  if (isdirectory(selected))
    exec "normal \<Plug>(fern-action-expand)"
  else
    call MyFernEdit(a:winnr)
  endif

  "exec "normal \<Plug>(fern-my-edit-expand-collapse)"

  let curr_winnr = winnr()
  if curr_winnr != prev_winnr
    exec "lcd" expand('%:p:h')
    wincmd p
  endif
endfunc

"------------------------------------------------------
func MyFernPrintItem()
  let key = MyFernSelected()
  if (len(key) > g:fern#drawer_width / 2)
    echo key
  else
    echo ""
  endif
endfunc

func MyFernPrevItem()
  normal -
  call MyFernPrintItem()
endfunc

func MyFernNextItem()
  normal +
  call MyFernPrintItem()
endfunc

"------------------------------------------------------
" statusline
"------------------------------------------------------
func MyFernStatuslineWinNr()
  let winnr = winnr()
  return '['.winnr.']'
endfunc

func MyFernStatusline()
  let stat = "%{MyFernStatuslineWinNr()}"
  let stat.= "\ %t"
  return stat
endfunc

func MyFernSetStatusline()
  setl statusline=%!MyFernStatusline()
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
  nmap <buffer> l     :call MyFernPreviewInFirstEditor()<CR>
  nmap <buffer> j     :call MyFernNextItem()<CR>
  nmap <buffer> k     :call MyFernPrevItem()<CR>

  nmap <buffer> 2     :call MyFernEdit(2)<CR>
  nmap <buffer> 3     :call MyFernEdit(3)<CR>
  nmap <buffer> 4     :call MyFernEdit(4)<CR>
  nmap <buffer> 5     :call MyFernEdit(5)<CR>
  nmap <buffer> 6     :call MyFernEdit(6)<CR>
  nmap <buffer> 7     :call MyFernEdit(7)<CR>
  nmap <buffer> 8     :call MyFernEdit(8)<CR>
  nmap <buffer> 9     :call MyFernEdit(9)<CR>

  nmap <silent> <buffer> <Space> :CpmOpen<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)

  setl statusline=%!MyFernStatusline()
endfunction

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command                         MyFernDrawerToggle call MyFernDrawerToggle()
command -nargs=1 -complete=dir  MyFernDrawer       call MyFernDrawer(<f-args>)
command -nargs=1 -complete=dir  MyFern             call MyFern(<f-args>)

