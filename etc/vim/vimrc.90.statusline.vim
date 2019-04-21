"------------------------------------------------------
" statusline
"------------------------------------------------------
hi User1 ctermfg=0 ctermbg=2 cterm=bold guifg=#000000 guibg=#90A959 gui=bold
hi User2 ctermfg=0 ctermbg=2 cterm=bold guifg=#000000 guibg=#90A959 gui=bold

set laststatus=2
set statusline=%1*%<%f%0*
set statusline+=\ %h%m%r%w%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}
set statusline+=%=%l/%L,%c%V%4p%%
set statusline+=\ %2*%{fugitive#statusline()}%0*
