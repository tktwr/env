"======================================================
" func
"======================================================
func MySetNoIgnoreCase()
  set noignorecase
  set nosmartcase
endfunc

func MySetIgnoreCase()
  set ignorecase
  set nosmartcase
endfunc

func MySetSmartCase()
  set ignorecase
  set smartcase
endfunc

"------------------------------------------------------
func YankFilePath()
  let @@ = expand('%:p')
endfunc

"------------------------------------------------------
func MyStartProf()
  profile start prof.txt
  profile func *
  profile file *
endfunc

func MyEndProf()
  profile pause
  noautocmd qall!
endfunc

