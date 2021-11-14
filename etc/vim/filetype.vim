" my filetype file

augroup ag_filetype
  au! BufNewFile,BufRead CMakeLists.txt setf cmake
  au! BufNewFile,BufRead *.txt          setf txt
  au! BufNewFile,BufRead *.cmd          setf txt
  au! BufNewFile,BufRead *.md           setf txt
  "au! BufNewFile,BufRead *.md.html      setf txt
  au! BufNewFile,BufRead *.md.html      setf markdown
  au! BufNewFile,BufRead *.glsl         setf cpp
  au! BufNewFile,BufRead *.frag         setf cpp
  au! BufNewFile,BufRead *.vert         setf cpp
augroup END

