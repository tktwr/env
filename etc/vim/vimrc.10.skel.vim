"======================================================
" skel
"======================================================
" load skeleton file

func s:AfterH()
  let header_id = substitute(expand("%:t"), "\\.", "_", "")
  silent exec "%s/HEADER_ID/".header_id."/"
endfunc
command AfterH call s:AfterH()

augroup ag-my-skel
  autocmd!
  autocmd BufNewFile Makefile        silent 0r $MY_VIM/skel/skel.make
  autocmd BufNewFile CMakeLists.txt  silent 0r $MY_VIM/skel/skel.cmake
  autocmd BufNewFile *.cxx,*.cpp     silent 0r $MY_VIM/skel/skel.cxx
  "autocmd BufNewFile *.h             silent 0r $MY_VIM/skel/skel.h | AfterH
  autocmd BufNewFile *.h             silent 0r $MY_VIM/skel/skel.h
  autocmd BufNewFile *.html          silent 0r $MY_VIM/skel/skel.html
  autocmd BufNewFile *.md.html       silent 0r $MY_VIM/skel/skel.md.html
  autocmd BufNewFile *.tex           silent 0r $MY_VIM/skel/skel.tex
  autocmd BufNewFile *.py            silent 0r $MY_VIM/skel/skel.py
  autocmd BufNewFile *.sh            silent 0r $MY_VIM/skel/skel.sh
augroup END

