Plug 't9md/vim-quickhl'

let g:quickhl_manual_colors = [
      \ "cterm=bold ctermfg=255 ctermbg=124 ",
      \ "cterm=bold ctermfg=255 ctermbg=172 ",
      \ "cterm=bold ctermfg=255 ctermbg=112 ",
      \ "cterm=bold ctermfg=255 ctermbg=34  ",
      \ "cterm=bold ctermfg=255 ctermbg=37  ",
      \ "cterm=bold ctermfg=255 ctermbg=27  ",
      \ "cterm=bold ctermfg=255 ctermbg=92  ",
      \ "cterm=bold ctermfg=255 ctermbg=161 ",
      \ ]

func MyQuickhl(word)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "QuickhlManualAdd!" word
endfunc

command -nargs=1 MyQuickhl   call MyQuickhl(<f-args>)

