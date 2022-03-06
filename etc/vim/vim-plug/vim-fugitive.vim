"------------------------------------------------------
" vim-fugitive
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'

"let g:fugitive_git_executable=git

"------------------------------------------------------
func MyGitLog()
  exec "0Git -p graph -10"
  call GitLogSyntax()
endfunc

"------------------------------------------------------
command          MyGitLog         call MyGitLog()

