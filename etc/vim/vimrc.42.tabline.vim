"======================================================
" tabline
"======================================================
func MyTabLabel(nr)
  let l:cwd = getcwd(-1, a:nr)
  let l:cwd = MyUnexpand(l:cwd)
  return "[".a:nr."] ".l:cwd

  "return g:my_tab_labels[a:nr-1]
endfunc

func MyTabLine()
  let s = ''

  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  let s .= "%="
  let s .= "\ [coc:%{coc#status()}]"
  let s .= "\ %{MyCWD()}"

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= "\ %#TabLine#%999X[close]"
  endif

  return s
endfunc

set tabline=%!MyTabLine()

"------------------------------------------------------
" set tab label
"------------------------------------------------------
let g:my_tab_labels = ["tab1", "tab2", "tab3", "tab4", "tab5"]

func MyTabSetLabel(label)
  let nr = tabpagenr()
  let g:my_tab_labels[nr-1] = a:label
endfunc

command -nargs=1 MyTabSetLabel      call MyTabSetLabel("<args>")
"------------------------------------------------------

