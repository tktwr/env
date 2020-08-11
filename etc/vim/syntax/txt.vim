" Vim syntax file
" Language: txt
" Maintainer: Takehiro Tawara

" Remove any old syntax stuff hanging around
syn clear
" syntax is case sensitive
syn case match

" see "help pattern"
syn match    myHtml             "<[^>]*>"
syn match    myHtml             "^http.*"

syn match    myComment          "<!--.*-->"
syn match    myComment          "#.*$"
syn match    myComment          "/\*"
syn match    myComment          "\*/"
"syn region   myComment          start="/\*" end="\*/"
"syn region   myComment          start=+(+ end=+)+

syn match    mySeparator        "^\s*--\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^\s*\~\~\+$"

syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    mySun              "½ËÆü"

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

syn match    myItem             "^\s*[-+] .*"
syn match    myItem0            "^[-+] .*"
syn match    myItem1            "^  [-+] .*"
syn match    myItem2            "^    [-+] .*"
syn match    myIdea             "^\s*-> .*"

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"
"syn region   myString           start=+"+ end=+"+ skip=+\\"+

syn match    myCitation         "^\s*>.*$"

"syn region   myType             start=+\[+ end=+\]+
syn match    myType             "^\[[^]]*\]"
"syn match    myType             "\w\+:"
syn match    myType             "@\w\+"
syn match    myNumber           "[-+]\=\d*\.\=\d\+"
syn match    myDate             "\d\+/\d\+/\d\+"
syn match    myTime             "\d\+:\d\+"
syn match    myTime             "\d\+:\d\+:\d\+"

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

  hi link myHtml             MyPurple

  hi link myTitle            Title
  hi link myComment          Comment
  hi link myString           String
  "hi link myType             Type
  hi link myNumber           Number
  hi link myHyperTextJump    Identifier
  hi link myHyperTextEntry   String

  hi link mySeparator        MyAqua
  hi link mySection1         MyAqua
  hi link mySection2         MyAqua
  hi link mySection3         MyAqua
  hi link myItem             MyGreen
  hi link myItem0            MyGreen
  hi link myItem1            MyGreen
  hi link myItem2            MyGreen
  hi link myIdea             MyPurple
  hi link myCitation         MyPurple
  hi link myDate             MyYellow
  hi link myTime             MyYellow
  hi link mySat              MyBlue
  hi link mySun              MyRed
endif

set textwidth=0

