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

