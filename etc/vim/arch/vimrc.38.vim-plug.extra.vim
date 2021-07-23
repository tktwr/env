"------------------------------------------------------
" vim-plug: move
"------------------------------------------------------
if 0
  " comfortable-motion
  Plug 'yuttie/comfortable-motion.vim'
  let g:comfortable_motion_no_default_key_mappings = 1
  let g:comfortable_motion_impulse_multiplier = 0.8
  if 1
    nnoremap <silent> <Space> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
    nnoremap <silent> <BS> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
  else
    nnoremap <silent> <Space> :call comfortable_motion#flick(200)<CR>
    nnoremap <silent> <BS> :call comfortable_motion#flick(-200)<CR>
  endif
  noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
  noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
endif

"------------------------------------------------------
" vim-plug: vim-which-key
"------------------------------------------------------
Plug 'liuchengxu/vim-which-key'

"------------------------------------------------------
" vim-plug: icons
"------------------------------------------------------
if has("gui_running")
  Plug 'ryanoasis/vim-devicons'
  "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif

"------------------------------------------------------
" vim-plug: airline
"------------------------------------------------------
if 0
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'ryanoasis/vim-devicons'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_theme = 'bubblegum'
endif

"------------------------------------------------------
