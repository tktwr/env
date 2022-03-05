"------------------------------------------------------
" command
"------------------------------------------------------
command! -nargs=+ BmkEditDir   call BmkEditDir(<f-args>)
command! -nargs=+ BmkEditFile  call BmkEditFile(<f-args>)

command!          CpmReload    call CpmReload()
command! -nargs=* CpmOpen      call CpmOpen(<f-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_bmk
  autocmd!
  autocmd FileType bmk      call BmkInit()
  autocmd BufWinEnter *     call BmkMapWin()
  autocmd WinEnter *        call BmkMapWin()
augroup END

