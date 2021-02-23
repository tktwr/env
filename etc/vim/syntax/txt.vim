" Vim syntax file
" Language: txt
" Maintainer: Takehiro Tawara

" Remove any old syntax stuff hanging around
syn clear
" syntax is case sensitive
syn case match

" see "help pattern"

syn match    myComment          "<!--.*-->"
syn match    myComment          "#.*$"
syn region   myComment          start="/\*" end="\*/"

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"

if has("ebcdic")
  syn match myHyperTextJump     "|[^"*|]\+|"
  syn match myHyperTextEntry    "\*[^"*|]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[^"*|]\+\*$"
else
  syn match myHyperTextJump     "|[#-)!+-~]\+|"
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*$"
endif

syn match    mySeparator        "^\s*--\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^\s*\~\~\+$"

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

syn match    myItem             "^\s*[-+*] "
syn match    myCitation         "^\s*>.*$"
syn match    myHtml             "<[^>]*>"
syn match    myHtml             "http://.*"
syn match    myHtml             "https://.*"

syn match    myDate             "\d\+/\d\+/\d\+"
syn match    myTime             "\d\+:\d\+"
syn match    myTime             "\d\+:\d\+:\d\+"
syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    myHoliday          "½ËÆü"

syn match    myTODO             "\[TODO\]"
syn match    myDONE             "\[DONE\]"
syn match    myFIXED            "\[FIXED\]"
syn match    mySOLVED           "\[SOLVED\]"
syn match    myOK               "\[OK\]"
syn match    myFAIL             "\[FAIL\]"

" Highlighting
" ============
if !exists("did_my_general_syntax_inits")
 " The default methods for highlighting. Can be overridden later
  let did_my_general_syntax_inits = 1

  hi link myComment          Comment
  hi link myString           MyAqua

  hi link myHyperTextJump    MyYellow
  hi link myHyperTextEntry   MyAqua

  hi link mySeparator        MyAqua

  hi link mySection1         MyAqua
  hi link mySection2         MyAqua
  hi link mySection3         MyAqua

  hi link myItem             MyOrange
  hi link myCitation         MyPurple
  hi link myHtml             MyPurple

  hi link myDate             MyYellow
  hi link myTime             MyYellow
  hi link mySat              MyBlue
  hi link mySun              MyRed
  hi link myHoliday          MyRed

  hi link myTODO             MyOrange
  hi link myDONE             MyGreen
  hi link myFIXED            MyGreen
  hi link mySOLVED           MyGreen
  hi link myOK               MyGreen
  hi link myFAIL             MyRed
endif

set textwidth=0

