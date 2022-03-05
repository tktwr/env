"------------------------------------------------------
" command for ide
"------------------------------------------------------
command                         MyIDE            call MyIDE()
command                         MyWinInitSize    call MyWinInitSize()

command                         MyBufDelete      call MyBufDelete()

"------------------------------------------------------
" command for tab
"------------------------------------------------------
command -nargs=+ -complete=file MyTabDiff        call MyTabDiff(<f-args>)
command -nargs=+ -complete=dir  MyTabDirDiff     call MyTabDirDiff(<f-args>)
command                         MyTabDirDiffQuit call MyTabDirDiffQuit()
command                         MyTabClosePrev   call MyTabClosePrev()

command -nargs=1                MyIDEVResizeT2E  call MyIDEVResizeT2E(<f-args>)
command -nargs=+ -complete=dir  MyIDESendCdT2T   call MyIDESendCdT2T(<f-args>)

"------------------------------------------------------
" command for window
"------------------------------------------------------
command -nargs=0 MyWinInfo        call MyWinInfo()
command -nargs=1 MyWinResize      call MyWinResize(<f-args>)
command -nargs=1 MyWinVResize     call MyWinVResize(<f-args>)
command -nargs=1 Wx               call MyWinBufExchange(<f-args>)
command -nargs=1 Wc               call MyWinBufCopy(<f-args>)

command MyRedraw                  call MyRedraw()

"------------------------------------------------------
" command for term
"------------------------------------------------------
command -nargs=? MyTerm         call MyTerm(<f-args>)
command -nargs=0 MyTermV        call MyTermV()

"------------------------------------------------------
" command for fern
"------------------------------------------------------
command                        MyFernDrawerToggle call MyFernDrawerToggle()
command -nargs=1 -complete=dir MyFernDrawer       call MyFernDrawer(<f-args>)
command -nargs=1 -complete=dir MyFern             call MyFern(<f-args>)

augroup ag_fern
  autocmd! *
  autocmd FileType fern          call glyph_palette#apply()
  autocmd FileType fern          call MyFernInit()
  autocmd User     FernSyntax    call MyFernSyntax()
  autocmd User     FernHighlight call MyFernHighlight()
augroup END

"------------------------------------------------------
" command for nerdtree
"------------------------------------------------------
command                        MyNERDTreeToggle call MyNERDTreeToggle()
command -nargs=1 -complete=dir MyNERDTreeFind   call MyNERDTreeFind(<f-args>)

augroup ag_nerdtree
  autocmd!
  autocmd FileType nerdtree call MyNERDTreeMap()
augroup END

