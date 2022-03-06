"======================================================
" func & command
"======================================================
"------------------------------------------------------
" source
"------------------------------------------------------
if !exists("g:my_source_vimrc")
  let g:my_source_vimrc = 1
  func s:MySourceVimrc()
    source ~/.vimrc
  endfunc
  command MySourceVimrc        call s:MySourceVimrc()
endif

"------------------------------------------------------
" command
"------------------------------------------------------
" apply the command to each entry in the quickfix list
command MyCdo      cdo  execute "normal! @q" | w
" apply the command to each file in the quickfix list
command MyCfdo     cfdo execute "normal! @q" | w

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

