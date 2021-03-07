"======================================================
" command
"======================================================
" apply the command to each entry in the quickfix list
command Cdo      cdo execute "normal! @q" | w
" apply the command to each file in the quickfix list
command Cfdo     cfdo execute "normal! @q" | w

command RunExplorer        silent !explorer.exe %:h
command RunGvim            silent !gvim "%"
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"

command TabBar             Tabularize /|
command TabDots            Tabularize /\.\.\.
command TabComma           Tabularize /,

command GgrepHere          Ggrep -I <cword> -- ':!*.dat'

command MyCdHere           cd %:h
command MyLcdHere          lcd %:h

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

