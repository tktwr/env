function! FzyCommand(vim_command, choice_command)
  try
    let output = system(printf("%s | fzy", a:choice_command))
    let output = substitute(output, '\n', '', 'g')
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec printf('call %s("%s")', a:vim_command, output)
  endif
endfunction

