" Vim syntax file
" Language:   txt
" Maintainer: Takehiro Tawara

" Remove any old syntax stuff hanging around
syn clear
" syntax is case sensitive
syn case match

" see "help pattern"
syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    mySun              "½ËÆü"

syn match    myItem             "^\s*[-+] .*"
syn match    myIdea             "^\s*-> .*"

syn match    mySeparator        "^\s*-\+$"
syn match    mySeparator        "^\s*=\+$"

syn match    myComment          "#.*$"
syn match    myComment          "/\*"
syn match    myComment          "\*/"
"syn region   myComment          start="/\*" end="\*/"
"syn region   myComment          start=+(+ end=+)+

"syn region   myString           start=+"+ end=+"+ skip=+\\"+

syn match    myCitation         "^\s*>.*$"

"syn region   myType             start=+\[+ end=+\]+
syn match    myType             "^\[[^]]*\]"
syn match    myType             "\w\+:"
syn match    myType             "@\w\+"
syn match    myNumber           "[-+]\=\d*\.\=\d\+"
syn match    myDate             "\d\+/\d\+/\d\+"
syn match    myTime             "\d\+:\d\+"

if has("ebcdic")
  syn match myHyperTextJump     "|[^"*|]\+|"
  syn match myHyperTextEntry    "\*[^"*|]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[^"*|]\+\*$"
else
  syn match myHyperTextJump     "|[#-)!+-~]\+|"
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*$"
endif

" Highlighting
" ============
if !exists("did_my_general_syntax_inits")
 " The default methods for highlighting. Can be overridden later
  let did_my_general_syntax_inits = 1

  hi link myTitle            Title
  hi link myComment          Comment
  hi link myString           String
  hi link myType             Type
  hi link myNumber           Number
  hi link myHyperTextJump    Identifier
  hi link myHyperTextEntry   String

  hi mySeparator ctermfg=4 cterm=bold
  hi myCitation ctermfg=5 cterm=bold
  hi myItem ctermfg=2 cterm=bold
  hi myIdea ctermfg=6 cterm=bold
  hi myDate ctermfg=3 cterm=bold
  hi myTime ctermfg=3 cterm=bold
  hi mySat ctermfg=4 cterm=bold
  hi mySun ctermfg=1 cterm=bold
endif

set textwidth=0

