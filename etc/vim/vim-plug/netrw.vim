"======================================================
" netrw
"======================================================
func s:netrw_view_in_next_win(fname)
  let fname = printf("%s/%s", expand('%'), expand(a:fname))

  call feedkeys("\<Plug>NetrwRefresh")
  if (isdirectory(fname))
    call feedkeys("\<Plug>NetrwLocalBrowseCheck")
  elseif (filereadable(fname))
    wincmd w
    exec "edit" fname
    wincmd p
  endif
endfunc

func s:netrw_settings()
  "mapclear <buffer>
  nmap     <buffer> h         <Plug>NetrwBrowseUpDir
  nnoremap <buffer> l         :call <SID>netrw_view_in_next_win('<cfile>')<CR>
endfunc

func s:netrw_ide()
  30vsp +e .
  wincmd w
  below term
  wincmd 1
endfunc

augroup ag_netrw
  autocmd!
  autocmd FileType netrw      call s:netrw_settings()
augroup END
"------------------------------------------------------
filetype plugin on
let g:netrw_banner=0
command NetrwIDE call s:netrw_ide()
