" load skeleton file

au BufNewFile Makefile        silent 0r ~/.vim/skel/skel.make
au BufNewFile CMakeLists.txt  silent 0r ~/.vim/skel/skel.cmake
au BufNewFile *.cxx,*.cpp     silent 0r ~/.vim/skel/skel.cxx
au BufNewFile *.h             silent 0r ~/.vim/skel/skel.h | AfterH
au BufNewFile *.html          silent 0r ~/.vim/skel/skel.html
au BufNewFile *.md.html       silent 0r ~/.vim/skel/skel.md.html
au BufNewFile *.tex           silent 0r ~/.vim/skel/skel.tex

