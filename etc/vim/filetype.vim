" my filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead *.txt          setf txt
  au! BufNewFile,BufRead *.md.html      setf md
augroup END

