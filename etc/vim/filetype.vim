" my filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead CMakeLists.txt setf cmake
  au! BufNewFile,BufRead *.txt          setf txt
  "au! BufNewFile,BufRead *.md.html      setf txt
  au! BufNewFile,BufRead *.md.html      setf markdown
augroup END

