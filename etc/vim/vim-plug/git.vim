"======================================================
" vim-fugitive
"======================================================
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'

let g:fugitive_git_executable='/usr/bin/git'

"------------------------------------------------------
func MyGitLog()
  exec "0Git -p graph -10"
  call GitLogSyntax()
endfunc

"------------------------------------------------------
command          MyGitLog         call MyGitLog()

"======================================================
" vim-gitgutter
"======================================================
if $MY_PROMPT_TYPE >= 1
  if &term =~ "xterm"
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_map_keys = 0
    let g:gitgutter_override_sign_column_highlight = 0
    highlight SignColumn ctermbg=0
  endif
endif

"======================================================
" gv
"======================================================
Plug 'junegunn/gv.vim'

func s:my_gv_settings()
endfunc

func s:my_git_settings()
  nmap <buffer> D       O
endfunc

augroup ag_gv
  autocmd!
  autocmd FileType GV       call s:my_gv_settings()
  autocmd FileType git      call s:my_git_settings()
augroup END

func MyGV()
  GV --all
endfunc

"------------------------------------------------------
command MyGV             call MyGV()

"======================================================
" agit
"======================================================
"Plug 'cohama/agit.vim'

