"======================================================
" skel
"======================================================
" load skeleton file

func s:AfterH()
  let header_id = substitute(expand("%:t"), "\\.", "_", "")
  silent exec "%s/HEADER_ID/".header_id."/"
endfunc
command AfterH call s:AfterH()

func s:LoadSkel()
  let fname = expand('%')
  if fname =~ '.md.html'
    silent 0r $MY_VIM/skel/skel.md.html
  elseif fname =~ '.html'
    silent 0r $MY_VIM/skel/skel.html
  elseif fname =~ 'make.sh'
    silent 0r $MY_VIM/skel/skel.make.sh
  elseif fname =~ '.sh'
    silent 0r $MY_VIM/skel/skel.sh
  endif
endfunc

augroup ag_my_skel
  autocmd!
  autocmd BufNewFile Makefile        silent 0r $MY_VIM/skel/skel.make
  autocmd BufNewFile CMakeLists.txt  silent 0r $MY_VIM/skel/skel.cmake
  autocmd BufNewFile *.cxx,*.cpp     silent 0r $MY_VIM/skel/skel.cxx
  "autocmd BufNewFile *.h             silent 0r $MY_VIM/skel/skel.h | AfterH
  autocmd BufNewFile *.h             silent 0r $MY_VIM/skel/skel.h
  autocmd BufNewFile *.tex           silent 0r $MY_VIM/skel/skel.tex
  autocmd BufNewFile *.py            silent 0r $MY_VIM/skel/skel.py

  autocmd BufNewFile *.sh            call s:LoadSkel()
  autocmd BufNewFile *.html          call s:LoadSkel()
augroup END

