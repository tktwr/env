"======================================================
" Window Buffer List
"======================================================
if v:version < 802
  finish
endif

if exists("g:loaded_wbl")
  finish
endif
let g:loaded_wbl = 1

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_wbl
  autocmd!
  autocmd BufEnter *   call WblPush(bufnr('%'))
  autocmd WinEnter *   call WblPush(bufnr('%'))
augroup END

"------------------------------------------------------
" init
"------------------------------------------------------
call WblInit()
