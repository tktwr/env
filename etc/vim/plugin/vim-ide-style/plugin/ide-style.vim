"------------------------------------------------------
" init
"------------------------------------------------------
let g:my_tab_labels = {}
let g:my_tab_info = ""

set laststatus=2
set statusline=%!MyStatusline()
set tabline=%!MyTabLine()

"------------------------------------------------------
" command for ide
"------------------------------------------------------
command                         MyIDE            call MyIDE()
command                         MyWinInitSize    call MyWinInitSize()

"------------------------------------------------------
" command for buffer
"------------------------------------------------------
command                         MyBufDelete      call MyBufDelete()

"------------------------------------------------------
" command for window
"------------------------------------------------------
command -nargs=1                MyWinResize      call MyWinResize(<f-args>)
command -nargs=1                MyWinVResize     call MyWinVResize(<f-args>)
command -nargs=1                Wx               call MyWinBufExchange(<f-args>)
command -nargs=1                Wc               call MyWinBufCopy(<f-args>)

command                         MyRedraw         call MyRedraw()

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
" command for tabline
"------------------------------------------------------
command -nargs=1                MyTabLineSetLabel call MyTabLine_SetLabel(<f-args>)
command -nargs=1                MyTabLineSetInfo  call MyTabLine_SetInfo(<f-args>)

"------------------------------------------------------
" command for term
"------------------------------------------------------
command -nargs=?                MyTerm             call MyTerm(<f-args>)
command -nargs=0                MyTermV            call MyTermV()

"------------------------------------------------------
" command for fern
"------------------------------------------------------
command                         MyFernDrawerToggle call MyFernDrawerToggle()
command -nargs=1 -complete=dir  MyFernDrawer       call MyFernDrawer(<f-args>)
command -nargs=1 -complete=dir  MyFern             call MyFern(<f-args>)

"------------------------------------------------------
" command for nerdtree
"------------------------------------------------------
command                         MyNERDTreeToggle   call MyNERDTreeToggle()
command -nargs=1 -complete=dir  MyNERDTreeFind     call MyNERDTreeFind(<f-args>)

"------------------------------------------------------
" command for fugitive
"------------------------------------------------------
command -nargs=1                MyGgrep            call MyGgrep(<f-args>)
command                         MyGstatusToggle    call MyGstatusToggle()

"------------------------------------------------------
" command for quickhl
"------------------------------------------------------
command -nargs=1                MyQuickhl          call MyQuickhl(<f-args>)

"------------------------------------------------------
" command for ref
"------------------------------------------------------
command -nargs=+                MyMan              call MyRef("man", <q-args>)
command -nargs=+                MyPydoc            call MyRef("pydoc", <q-args>)

"------------------------------------------------------
" command for help
"------------------------------------------------------
command -nargs=?                MyHelp             call MyHelp(<f-args>)

"------------------------------------------------------
" command for vimgrep
"------------------------------------------------------
command -nargs=+                MyVimgrep          call MyVimgrep(<f-args>)

"------------------------------------------------------
" command for tag jump
"------------------------------------------------------
command -nargs=+                MyTjump            call MyTjump(<f-args>)

"------------------------------------------------------
" command for util
"------------------------------------------------------
command -nargs=1                MySetTab           call MySetTab(<f-args>)
command                         MyLineNumberToggle call MyLineNumberToggle()

command                         MyCheckEnv         call MyCheckEnv()
command -nargs=0                MyWinInfo          call MyWinInfo()

command                         MyCdHere           exec "cd"  expand("%:p:h")
command                         MyTcdHere          exec "tcd" expand("%:p:h")
command                         MyLcdHere          exec "lcd" expand("%:p:h")

"------------------------------------------------------
" autocmd
"------------------------------------------------------
augroup ag_ide_map
  autocmd!
  autocmd WinEnter        *      call MyBufferMap()
  autocmd QuickFixCmdPost *grep* below cwindow
  autocmd QuickFixCmdPost *make* below cwindow
augroup END

augroup ag_ide_term
  autocmd!
  if !has('nvim')
    autocmd TerminalOpen *       call MySetStatuslineForTerm()
  else
    autocmd TermOpen     *       call MySetStatuslineForTerm()
  endif
augroup END

augroup ag_ide_bmk
  autocmd!
  autocmd FileType bmk           call TtSetStatuslineForSideBar()
augroup END

augroup ag_ide_fern
  autocmd!
  autocmd FileType fern          call glyph_palette#apply()
  autocmd FileType fern          call TtSetStatuslineForSideBar()
  autocmd FileType fern          call MyFernMap()
  autocmd User     FernSyntax    call MyFernSyntax()
  autocmd User     FernHighlight call MyFernHighlight()
augroup END

augroup ag_ide_nerdtree
  autocmd!
  autocmd FileType nerdtree      call MyNERDTreeMap()
augroup END

augroup ag_ide_fugitive
  autocmd!
  autocmd FileType fugitive      call MyFugitiveMap()
augroup END

