"======================================================
" MyMenu
"======================================================
if exists("g:loaded_my_menu")
  finish
endif
let g:loaded_my_menu = 1

let g:my_menu_edit = [
  \ [
  \ ':edit $MY_DIARY/scratchpad.md.html',
  \ ':edit $MY_DOTMY_COMMON/bmk.txt',
  \ '"*p',
  \ '"*y',
  \ ':silent MyGgrepHere',
  \ ':MyClangFormat',
  \ ':MyTabBar',
  \ ':MyMakeLink',
  \ ':MyTogglePathFormat',
  \ ':confirm qall',
  \ ],
  \ [
  \ ':MyGitLog',
  \ ':MyHelp',
  \ ':MyMemo',
  \ ':MyLcdHere',
  \ ':MyWinInitSize',
  \ ':call MyIDESendCdE2T("")',
  \ ':call BmkOpenThis()',
  \ ':call BmkKeyCRThis()',
  \ ],
  \ ]
let g:my_menu_term = [
  \ [
  \ 'G',
  \ 'git status',
  \ 'git fetch',
  \ ],
  \ [
  \ ',resize 40',
  \ ',resize 10',
  \ ],
  \ ]
let s:my_menu_edit = g:my_menu_edit
let s:my_menu_term = g:my_menu_term

func MyMenuList(nr)
  if &buftype == 'terminal'
    return s:my_menu_term[a:nr]
  else
    return s:my_menu_edit[a:nr]
  endif
endfunc

func MyMenuExec(cmd)
  call BmkExecCommand(a:cmd, 0)
endfunc

"------------------------------------------------------
" load
"------------------------------------------------------
let s:cmd_file = "$MY_ETC/bmk/cmd.txt"
let s:cmd_dict = {}

func s:MyMenuRegister(list, dict, line)
  let line = a:line
  let key = BmkGetItem(line, 1)
  let val = BmkGetItem(line, 2)

  let key = BmkRemoveEndSpaces(key)

  let a:dict[key] = val
  call add(a:list, key)
endfunc

func s:MyMenuLoad(cmd_file)
  let s:my_menu_edit = []
  let s:my_menu_term = []

  let cmd_file = expand(a:cmd_file)
  if !filereadable(cmd_file)
    return
  endif
  let lines = readfile(cmd_file)
  for line in lines
    if (match(line, '^\[.\+\]') == 0)
      let title = BmkGetTitle(line)
      if (match(title, 'terminal') == 0)
        call add(s:my_menu_term, [])
      else
        call add(s:my_menu_edit, [])
      endif
      continue
    elseif (match(line, '^\s*-') == -1)
      continue
    endif
    if (match(title, 'terminal') == 0)
      call s:MyMenuRegister(s:my_menu_term[-1], s:cmd_dict, line)
    else
      call s:MyMenuRegister(s:my_menu_edit[-1], s:cmd_dict, line)
    endif
  endfor
endfunc

call s:MyMenuLoad(s:cmd_file)

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func MyMenuNext()
  if &buftype == 'terminal'
    return (w:my_menu_nr + 1) % len(s:my_menu_term)
  else
    return (w:my_menu_nr + 1) % len(s:my_menu_edit)
  endif
endfunc

func MyMenuPrev()
  if &buftype == 'terminal'
    return w:my_menu_nr == 0 ? len(s:my_menu_term) - 1 : w:my_menu_nr - 1
  else
    return w:my_menu_nr == 0 ? len(s:my_menu_edit) - 1 : w:my_menu_nr - 1
  endif
endfunc

func MyMenuPopupMenuFilter(id, key)
  if a:key == 'c'
    call popup_close(a:id, 0)
    return 1
  elseif a:key == 'a'
    call popup_move(a:id, #{
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ })
    return 1
  elseif a:key == 'l'
    call popup_close(a:id, 0)
    let nr = MyMenuNext()
    call MyMenuPopupMenu(nr)
    return 1
  elseif a:key == 'h'
    call popup_close(a:id, 0)
    let nr = MyMenuPrev()
    call MyMenuPopupMenu(nr)
    return 1
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func MyMenuPopupMenuHandler(id, result)
  if a:result == 0
  elseif a:result > 0
    let idx = a:result - 1

    " command in menu
    "let cmd = w:my_menu[idx]

    " key in menu
    let cmd = s:cmd_dict[w:my_menu[idx]]

    call MyMenuExec(cmd)
  endif
endfunc

func MyMenuPopupMenu(menu_nr)
  let w:my_menu_nr = a:menu_nr
  let w:my_menu = MyMenuList(w:my_menu_nr)
  let winid = popup_menu(w:my_menu, #{
    \ filter: 'MyMenuPopupMenuFilter',
    \ callback: 'MyMenuPopupMenuHandler',
    \ border: [0,0,0,0],
    \ padding: [0,0,0,0],
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ moved: 'WORD',
    \ })
endfunc

