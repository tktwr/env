"======================================================
" Bmk
"======================================================
if v:version < 802
  finish
endif

if exists("g:loaded_bmk")
  finish
endif
let g:loaded_bmk = 1

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
  autocmd FileType bmk      call TtSetStatuslineForSideBar()
  autocmd BufWinEnter *     call BmkMapWin()
  autocmd WinEnter *        call BmkMapWin()
augroup END

"------------------------------------------------------
" init
"------------------------------------------------------
call BmkInit()
