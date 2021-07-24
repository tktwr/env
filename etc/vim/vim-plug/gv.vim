"------------------------------------------------------
" gv
"------------------------------------------------------
Plug 'junegunn/gv.vim'

func s:my_gv_settings()
endfunc

func s:my_git_settings()
  nmap <buffer> D       O
endfunc

augroup ag-gv
  autocmd!
  autocmd FileType GV       call s:my_gv_settings()
  autocmd FileType git      call s:my_git_settings()
augroup END

func MyGV()
  GV --all
endfunc

"------------------------------------------------------
command MyGV             call MyGV()

