"======================================================
" tabline
"======================================================
func MyTabLabel(nr)
  let l:cwd = getcwd(-1, a:nr)
  let l:cwd = MyUnexpand(l:cwd)
  return "[".a:nr."] ".l:cwd

  "return g:my_tab_labels[a:nr-1]
endfunc

func MyTabLineEnv()
  let python_type = expand("$MY_PYTHON_TYPE")
  let python_venv = expand("$MY_PYTHON_VENV")
  let python_info = "[".python_type.",".python_venv."]"

  let build_sys = expand("$MY_BUILD_SYS")
  let build_config = expand("$MY_BUILD_CONFIG")
  let build_info = "[".build_sys.",".build_config."]"

  return python_info.build_info
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
  if $MY_PROMPT_TYPE >= 3
    let s .= "\ [coc:%{coc#status()}]"
  endif
  let s .= "\ %6*%{MyCWD()}%0*"
  let s .= "\ %6*%{MyTabLineEnv()}%0*"

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= "\ %#TabLine#%999X[x]"
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

