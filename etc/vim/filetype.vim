" my filetype file

augroup ag_filetype
  au! BufNewFile,BufRead CMakeLists.txt setf cmake
  au! BufNewFile,BufRead *.txt          setf txt
  au! BufNewFile,BufRead *.cmd          setf txt
  au! BufNewFile,BufRead *.md           set syntax=txt
  au! BufNewFile,BufRead *.md.html      setf markdown
  "au! BufNewFile,BufRead *.md.html      setf txt
augroup END

