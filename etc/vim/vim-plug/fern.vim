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

func MyFernEditItem(winnr)
  let selected = MyFernSelected()
  if (selected == "")
    return
  endif

  call BmkEdit(selected, a:winnr)
endfunc

func MyFernPreviewItem(winnr)
  let selected = MyFernSelected()
  if (isdirectory(selected))
    exec "normal \<Plug>(fern-action-expand)"
  elseif selected != ""
    let prev_winnr = winnr()
    call BmkEdit(selected, a:winnr)
    exec prev_winnr."wincmd w"
  endif
endfunc

"------------------------------------------------------
func MyFernOpenItem()
  let selected = MyFernSelected()
  call BmkOpen(selected, 0)
endfunc

func MyFernViewItem()
  let selected = MyFernSelected()
  call BmkView(selected, 0)
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
function! s:init_fern() abort
  nmap <buffer><expr>
        \ <Plug>(my-fern-select-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> <2-LeftMouse> <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <CR>          <Plug>(my-fern-select-expand-collapse)
  nmap <buffer> <C-CR>        :call MyFernViewItem()<CR>
  nmap <buffer> <S-CR>        :call MyFernOpenItem()<CR>

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
  nmap <buffer> l     :call MyFernPreviewItem(-2)<CR>
  nmap <buffer> j     :call MyFernNextItem()<CR>
  nmap <buffer> k     :call MyFernPrevItem()<CR>

  nmap <buffer> 2     :call MyFernEditItem(2)<CR>
  nmap <buffer> 3     :call MyFernEditItem(3)<CR>
  nmap <buffer> 4     :call MyFernEditItem(4)<CR>
  nmap <buffer> 5     :call MyFernEditItem(5)<CR>
  nmap <buffer> 6     :call MyFernEditItem(6)<CR>
  nmap <buffer> 7     :call MyFernEditItem(7)<CR>
  nmap <buffer> 8     :call MyFernEditItem(8)<CR>
  nmap <buffer> 9     :call MyFernEditItem(9)<CR>

  nmap <silent> <buffer> <Space> :CpmOpen<CR>

  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)

  call TtSetStatusline()
endfunction

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_fern
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd FileType fern call glyph_palette#apply()
augroup END

"------------------------------------------------------
" command
"------------------------------------------------------
command                        MyFernDrawerToggle call MyFernDrawerToggle()
command -nargs=1 -complete=dir MyFernDrawer       call MyFernDrawer(<f-args>)
command -nargs=1 -complete=dir MyFern             call MyFern(<f-args>)

