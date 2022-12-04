func Func()
  let i = 1
  let f = 1.5
  let l = [0, 1, 2]
  let d = {'a': 0, 'b': 1}
  " ---------- [print] ----------
  echom i
  echom f
  echom i + f
  echom l
  echom l[0:2]
  echom d
  echom d['a']
  " ---------- [if] ----------
  if v:true && v:true
  endif

  if v:true || v:true
  endif

  if v:true
  elseif v:true
  else
  endif
  " ---------- [for] ----------
  for x in l
    echom x
  endfor
endfunc

call Func()
