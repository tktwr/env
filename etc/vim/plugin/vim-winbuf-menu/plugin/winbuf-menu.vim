"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_wbl
  autocmd!
  autocmd BufEnter *   call WblPush(bufnr('%'))
  autocmd WinEnter *   call WblPush(bufnr('%'))
augroup END

