"------------------------------------------------------
" vim-fugitive
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'

let g:fugitive_git_executable=$MY_GIT_EXE

func s:my_fugitive_settings()
  nmap <buffer> D       dd
endfunc

augroup ag_fugitive
  autocmd!
  autocmd FileType fugitive call s:my_fugitive_settings()
augroup END

"------------------------------------------------------
func s:MyGgrep(word)
  "Ggrep -I a:word -- ':!*.dat'
  exec "Ggrep -I" a:word
endfunc

func s:MyGgrepHere()
  "Ggrep -I <cword> -- ':!*.dat'
  Ggrep -I <cword>
  redraw!
endfunc

func MyGitLog()
  exec "0Git -p graph -10"
  call GitLogSyntax()
endfunc

func MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    above Git
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

"------------------------------------------------------
command -nargs=+ MyGgrep          call s:MyGgrep("<args>")
command -nargs=0 MyGgrepHere      call s:MyGgrepHere()
command          MyGitLog         call MyGitLog()
command          MyGstatusToggle  call MyGstatusToggle()

