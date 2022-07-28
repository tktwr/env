" Vim syntax file
" Language: txt
" see "help pattern"

"------------------------------------------------------
" syntax
"------------------------------------------------------
syn clear
" syntax is case sensitive
syn case match

syn match    myComment          "#.*$"
syn region   myComment          start="/\*" end="\*/"
syn region   myDetails          start=+<details>+ end=+</details>+

syn match    mySection1         "^# "
syn match    mySection2         "^## "
syn match    mySection3         "^### "

syn match    myItem             "^\s*[-+*] "
syn match    myCitation         "^\s*>.*$"

syn match    myString           '"[^"]*"'
syn match    myString           "'[^']*'"
syn match    myHtml             "<[^>]*>"
syn match    myHtml             "http://.*"
syn match    myHtml             "https://.*"
syn match    myDir              "[/\.\-0-9A-Za-z_]\+/"
syn match    myVar              "\$\w\+"

syn match    myDate             "\d\{1,2}/\d\{1,2}"
syn match    myDate             "\d\{4}/\d\{2}/\d\{2}"
syn match    myTime             "\d\{1,2}:\d\{1,2}"
syn match    myTime             "\d\{1,2}:\d\{1,2}:\d\{1,2}"
syn keyword  mySat              Sat
syn keyword  mySun              Sun
syn keyword  myHoliday          ½ËÆü
syn keyword  myHoliday          Holiday

syn match    myTagR             '([^)]*)' contains=mySat,mySun
syn match    myTag              "\[[^]]*\]" contains=myDate,myWORK,myINFO,myTODO,myOK,myFAIL

syn keyword  myWORK             WORK contained
syn keyword  myINFO             INFO contained
syn keyword  myTODO             TODO
syn keyword  myOK               OK DONE FIXED SOLVED contained
syn keyword  myFAIL             FAIL CANCEL OBSOLETE contained

syn match    myRed              "\[ *Red *\]"
syn match    myGreen            "\[ *Green *\]"
syn match    myYellow           "\[ *Yellow *\]"
syn match    myBlue             "\[ *Blue *\]"
syn match    myPurple           "\[ *Purple *\]"
syn match    myAqua             "\[ *Aqua *\]"
syn match    myOrange           "\[ *Orange *\]"

syn match    myLowProgress      "\[ *.%\]"
syn match    myLowProgress      "\[ *[1-2].%\]"
syn match    myMidProgress      "\[ *[3-7].%\]"
syn match    myHighProgress     "\[ *[8-9].%\]"
syn match    myHighProgress     "\[100%\]"

syn match    mySeparator        "<!--.*-->"
syn match    mySeparator        "^\s*--\+$"
syn match    mySeparator        "^\s*==\+$"
syn match    mySeparator        "^\s*\~\~\+$"

if has("ebcdic")
  syn match myHyperTextJump     "|[^"*|]\+|"
  syn match myHyperTextEntry    "\*[^"*|]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[^"*|]\+\*$"
else
  syn match myHyperTextJump     "|[#-)!+-~]\+|"
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*\s"he=e-1
  syn match myHyperTextEntry    "\*[#-)!+-~]\+\*$"
endif

"------------------------------------------------------
" highlight
"------------------------------------------------------
hi link myComment          MyBlue
hi link myDetails          MyBlue

hi link mySection1         MyOrange
hi link mySection2         MyOrange
hi link mySection3         MyOrange

hi link myItem             MyOrange
hi link myCitation         MyPurple

hi link myString           MyAqua
hi link myHtml             MyPurple
hi link myDir              MyAqua
hi link myVar              MyGreen

hi link myDate             MyYellow
hi link myTime             MyYellow
hi link mySat              MyBlue
hi link mySun              MyRed
hi link myHoliday          MyRed

hi link myTagR             MyAqua
hi link myTag              MyPurple

hi link myWORK             MyBlue
hi link myINFO             MyYellow
hi link myTODO             MyOrange
hi link myOK               MyGreen
hi link myFAIL             MyRed

hi link myRed              MyRed  
hi link myGreen            MyGreen 
hi link myYellow           MyYellow
hi link myBlue             MyBlue  
hi link myPurple           MyPurple
hi link myAqua             MyAqua  
hi link myOrange           MyOrange

hi link myLowProgress      MyRed
hi link myMidProgress      MyOrange
hi link myHighProgress     MyGreen

hi link mySeparator        MyAqua

hi link myHyperTextJump    MyYellow
hi link myHyperTextEntry   MyAqua

set textwidth=0

