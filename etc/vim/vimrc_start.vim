"------------------------------------------------------
" IsWsl
"------------------------------------------------------
func IsWsl()
  if has('unix')
    if (match(system('uname -a'), 'WSL') != -1)
      return 1
    endif
  endif
  return 0
endfunc

"------------------------------------------------------
" SourceFile
"------------------------------------------------------
func SourceFile(fname)
  let fname = expand(a:fname)
  if filereadable(fname)
    exec "source" fname
  else
    if $MY_DEBUG == 1
      echo "no file:" fname
    endif
  endif
endfunc

command -nargs=1 SourceFile    call SourceFile(<f-args>)

"------------------------------------------------------
" SourceVimrc
"------------------------------------------------------
if !exists("g:my_source_vimrc")
  let g:my_source_vimrc = 1
  func s:SourceVimrc()
    source $HOME/.vimrc
  endfunc
  command SourceVimrc        call s:SourceVimrc()
endif

