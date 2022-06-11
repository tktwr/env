function! FzyCommand(vim_func, fzy_cmd, word='')
  try
    let fzy_cmd = a:fzy_cmd
    let word = a:word

    if word != ''
      let word = vis#util#VisPrompt("Word? ", word)
      if word != ''
        let fzy_cmd = printf('%s %s', fzy_cmd, word)
      endif
    endif

    let output = system(fzy_cmd)
    let output = substitute(output, '\n', '', 'g')
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry

  redraw!

  if v:shell_error == 0 && !empty(output)
    exec printf('call %s("%s")', a:vim_func, output)
  endif
endfunction

