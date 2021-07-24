"------------------------------------------------------
" nerdtree-git-plugin
"------------------------------------------------------
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusEnable=1
let g:NERDTreeGitStatusShowIgnored=0
let g:NERDTreeGitStatusIgnoreSubmodules=1
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : 'M',
    \ 'Staged'    : 'S',
    \ 'Untracked' : 'U',
    \ 'Renamed'   : 'R',
    \ 'Unmerged'  : 'm',
    \ 'Deleted'   : 'D',
    \ 'Dirty'     : '!',
    \ 'Clean'     : 'C',
    \ 'Ignored'   : 'I',
    \ 'Unknown'   : 'u'
    \ }
