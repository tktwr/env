"------------------------------------------------------
" netrw
"------------------------------------------------------
func s:view_in_next_win(fname)
  let fname = printf("%s/%s", expand('%'), expand(a:fname))

  if (isdirectory(fname))
    call feedkeys("\<Plug>NetrwLocalBrowseCheck")
  elseif (filereadable(fname))
    wincmd w
    exec "edit" fname
    wincmd p
  endif
endfunc

func s:ide_netrw_settings()
  "mapclear <buffer>
  nmap     <buffer> h         <Plug>NetrwBrowseUpDir
  nnoremap <buffer> l         :call <SID>view_in_next_win('<cfile>')<CR>
endfunc

augroup ag_ide_netrw
  autocmd!
  autocmd FileType netrw      call s:ide_netrw_settings()
augroup END

command NetrwIDE 30vsp +e .
