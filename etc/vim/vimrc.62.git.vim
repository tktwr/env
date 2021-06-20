"------------------------------------------------------
" git
"------------------------------------------------------

func MyGitLog()
  exec "0Git -p graph -10"
  call GitLogSyntax()
endfunc

command MyGitLog           call MyGitLog()

