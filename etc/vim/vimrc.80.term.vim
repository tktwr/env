"======================================================
" term
"======================================================
if has('vim_starting') && (&term =~ "xterm")
  " mouse support
  set mouse=a
  set ttymouse=xterm2

  " t_SI: set bar cursor in insert mode
  " t_SR: set underline cursor in replace mode
  " t_EI: set block cursor in normal mode
  let bar_cursor       = "\e[6 q"
  let underline_cursor = "\e[4 q"
  let block_cursor     = "\e[2 q"
  let &t_SI = "\e]12;red\x7" . bar_cursor
  let &t_SR = "\e]12;red\x7" . underline_cursor
  let &t_EI = "\e]12;orange\x7" . block_cursor
endif

"------------------------------------------------------
" terminal window
"------------------------------------------------------
"set notimeout ttimeout

