" load skeleton file

func s:AfterH()
  let header_id = substitute(expand("%:t"), "\\.", "_", "")
  silent exec "%s/HEADER_ID/".header_id."/"
endfunc
command AfterH call s:AfterH()

au BufNewFile Makefile        silent 0r ~/.vim/skel/skel.make
au BufNewFile CMakeLists.txt  silent 0r ~/.vim/skel/skel.cmake
au BufNewFile *.cxx,*.cpp     silent 0r ~/.vim/skel/skel.cxx
au BufNewFile *.h             silent 0r ~/.vim/skel/skel.h | AfterH
au BufNewFile *.html          silent 0r ~/.vim/skel/skel.html
au BufNewFile *.md.html       silent 0r ~/.vim/skel/skel.md.html
au BufNewFile *.tex           silent 0r ~/.vim/skel/skel.tex

