"------------------------------------------------------
" vim-fugitive
"------------------------------------------------------
"Plug 'tpope/vim-fugitive', { 'tag': 'v2.5' }
Plug 'tpope/vim-fugitive'

"let g:fugitive_git_executable=git

func s:my_fugitive_settings()
  nmap <buffer> D       dd
endfunc

augroup ag_fugitive
  autocmd!
  autocmd FileType fugitive call s:my_fugitive_settings()
augroup END

"------------------------------------------------------
func s:MyGgrep(word)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "Ggrep -I" word "-- ':!tags*'"
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
command -nargs=1 MyGgrep          call s:MyGgrep(<f-args>)
command          MyGitLog         call MyGitLog()
command          MyGstatusToggle  call MyGstatusToggle()

