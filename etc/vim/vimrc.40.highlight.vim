"======================================================
" highlight
"======================================================
hi MyRed           ctermfg=167 guifg=#fb4934
hi MyGreen         ctermfg=142 guifg=#b8bb26
hi MyYellow        ctermfg=214 guifg=#fabd2f
hi MyBlue          ctermfg=109 guifg=#707fd9
hi MyPurple        ctermfg=175 guifg=#d3869b
hi MyAqua          ctermfg=108 guifg=#8ec07c
hi MyOrange        ctermfg=208 guifg=#fe8019

hi MyRedRevBold    ctermfg=167 guifg=#fb4934 cterm=reverse,bold gui=reverse,bold
hi MyGreenRevBold  ctermfg=142 guifg=#b8bb26 cterm=reverse,bold gui=reverse,bold
hi MyYellowRevBold ctermfg=214 guifg=#fabd2f cterm=reverse,bold gui=reverse,bold
hi MyBlueRevBold   ctermfg=109 guifg=#707fd9 cterm=reverse,bold gui=reverse,bold
hi MyPurpleRevBold ctermfg=175 guifg=#d3869b cterm=reverse,bold gui=reverse,bold
hi MyAquaRevBold   ctermfg=108 guifg=#8ec07c cterm=reverse,bold gui=reverse,bold
hi MyOrangeRevBold ctermfg=208 guifg=#fe8019 cterm=reverse,bold gui=reverse,bold

hi MyRedSign       ctermfg=167 guifg=#fb4934 ctermbg=237 guibg=#3c3836
hi MyGreenSign     ctermfg=142 guifg=#b8bb26 ctermbg=237 guibg=#3c3836
hi MyYellowSign    ctermfg=214 guifg=#fabd2f ctermbg=237 guibg=#3c3836
hi MyBlueSign      ctermfg=109 guifg=#83a598 ctermbg=237 guibg=#3c3836
hi MyPurpleSign    ctermfg=175 guifg=#d3869b ctermbg=237 guibg=#3c3836
hi MyAquaSign      ctermfg=108 guifg=#8ec07c ctermbg=237 guibg=#3c3836
hi MyOrangeSign    ctermfg=208 guifg=#fe8019 ctermbg=237 guibg=#3c3836

hi MyFg0           ctermfg=229 guifg=#fbf1c7
hi MyFg1           ctermfg=223 guifg=#ebdbb2
hi MyFg2           ctermfg=250 guifg=#d5c4a1
hi MyFg3           ctermfg=248 guifg=#bdae93
hi MyFg4           ctermfg=246 guifg=#a89984
hi MyBg5           ctermbg=245 guibg=#928374
hi MyBg4           ctermbg=243 guibg=#7c6f64
hi MyBg3           ctermbg=241 guibg=#665c54
hi MyBg2           ctermbg=239 guibg=#504945
hi MyBg1a          ctermbg=237 guibg=#3c3c36
hi MyBg1           ctermbg=237 guibg=#3c3836
hi MyBg0           ctermbg=236 guibg=#32302f
hi MyBgTerm        ctermbg=235 guibg=#252525

hi MyNormal        ctermfg=223 ctermbg=236 guifg=#ebdbb2 guibg=#32302f
hi MyStatusLine    cterm=reverse ctermfg=239 ctermbg=223 gui=reverse guifg=#504945 guibg=#ebdbb2 term=reverse,bold
hi MyStatusLineNC  cterm=reverse ctermfg=237 ctermbg=246 gui=reverse guifg=#3c3836 guibg=#a89984 term=reverse

hi! link CocFloating      MyNormal

hi! link StatusLine       MyStatusLine
hi! link StatusLineNC     MyStatusLineNC
hi! link StatusLineTerm   MyAquaRevBold
hi! link StatusLineTermNC MyStatusLineNC

hi! link TabLineSel       MyAquaRevBold
hi! link TabLine          MyStatusLine
hi! link TabLineFill      MyStatusLineNC

hi! link Folded           MyYellowSign
hi! link FoldColumn       MyYellowSign

hi! link WildMenu         MyYellowRevBold
hi! link WhichKeyFloating MyYellowSign
hi! link IndentGuidesOdd  MyBg0
hi! link IndentGuidesEven MyBg1a

hi! link Terminal         MyBgTerm

hi! link CocErrorHighlight  MyRedRevBold

hi! link User1   MyRedRevBold
hi! link User2   MyGreenRevBold
hi! link User3   MyYellowRevBold
hi! link User4   MyBlueRevBold
hi! link User5   MyPurpleRevBold
hi! link User6   MyAquaRevBold
hi! link User7   MyOrangeRevBold

