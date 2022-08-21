"======================================================
" func & command
"======================================================
"------------------------------------------------------
" command
"------------------------------------------------------
" apply the command to each entry in the quickfix list
command MyCdo      cdo  execute "normal! @q" | w
" apply the command to each file in the quickfix list
command MyCfdo     cfdo execute "normal! @q" | w

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

