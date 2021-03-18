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
syn match    myVar              "\$\w\+"

syn match    myDate             "\d\+/\d\+/\d\+"
syn match    myTime             "\d\+:\d\+"
syn match    myTime             "\d\+:\d\+:\d\+"
syn match    mySat              "(Sat)"
syn match    mySun              "(Sun)"
syn match    myHoliday          "½ËÆü"

syn match    myTODO             "\[TODO\]"
syn match    myDONE             "\[DONE\]"
syn match    myCANCEL           "\[CANCEL\]"
syn match    myFIXED            "\[FIXED\]"
syn match    mySOLVED           "\[SOLVED\]"
syn match    myOK               "\[OK\]"
syn match    myFAIL             "\[FAIL\]"

syn match    myRed              "\[ Red    \]"
syn match    myGreen            "\[ Green  \]"
syn match    myYellow           "\[ Yellow \]"
syn match    myBlue             "\[ Blue   \]"
syn match    myPurple           "\[ Purple \]"
syn match    myAqua             "\[ Aqua   \]"
syn match    myOrange           "\[ Orange \]"

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

  hi link mySection1         MyOrange
  hi link mySection2         MyOrange
  hi link mySection3         MyOrange

  hi link myItem             MyOrange
  hi link myCitation         MyPurple
  hi link myHtml             MyPurple
  hi link myVar              MyGreen

  hi link myDate             MyYellow
  hi link myTime             MyYellow
  hi link mySat              MyBlue
  hi link mySun              MyRed
  hi link myHoliday          MyRed

  hi link myTODO             MyOrange
  hi link myDONE             MyGreen
  hi link myCANCEL           MyRed
  hi link myFIXED            MyGreen
  hi link mySOLVED           MyGreen
  hi link myOK               MyGreen
  hi link myFAIL             MyRed

  hi link myRed              MyRed  
  hi link myGreen            MyGreen 
  hi link myYellow           MyYellow
  hi link myBlue             MyBlue  
  hi link myPurple           MyPurple
  hi link myAqua             MyAqua  
  hi link myOrange           MyOrange
endif

set textwidth=0

