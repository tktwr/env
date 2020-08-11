" Vim syntax file
" Language: nerdtree
" Maintainer: Takehiro Tawara

syn match ntMakefile      ".*Makefile"
syn match ntCMakeLists    ".*CMakeLists.txt"

if !exists("did_nt_syntax_inits")
  let did_nt_syntax_inits = 1
  hi link ntMakefile      MyRed
  hi link ntCMakeLists    MyRed
endif

