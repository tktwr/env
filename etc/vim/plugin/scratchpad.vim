"------------------------------------------------------
" Scratchpad
"------------------------------------------------------
if exists("loaded_scratchpad")
  finish
endif

let loaded_scratchpad = 1
let s:scratchpad_file = g:my_scratchpad_file

func s:Scratchpad(sp)
  exec a:sp s:scratchpad_file
endfunc

command Scratchpad         call s:Scratchpad("sp")

