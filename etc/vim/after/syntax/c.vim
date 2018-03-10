" Vim syntax file
" Language:   C
" Maintainer: Takehiro Tawara

syn keyword glType      GLenum GLboolean GLbitfield
syn keyword glType      GLbyte GLshort GLint GLsizei 
syn keyword glType      GLubyte GLushort GLuint
syn keyword glType      GLfloat GLclampf GLdouble GLclampd 
syn keyword glType      GLvoid
syn match   glConstant  "GL_[A-Z0-9_]\+"
syn keyword glLabel     glBegin glPushMatrix glPushAttrib
syn keyword glLabel     glEnd glPopMatrix glPopAttrib

if !exists("did_gl_syntax_inits")
  let did_gl_syntax_inits = 1
  hi link glType        Type
  hi link glConstant    Constant
  hi link glLabel       Label
endif

syn keyword cppType     uchar ushort uint ulong Float

" SLT
syn keyword cppType     std
syn keyword cppType     vector list deque stack queue priority_queue
syn keyword cppType     map multimap set multiset
syn keyword cppType     string array valarray bitset

if !exists("did_cpp_syntax_inits")
  let did_cpp_syntax_inits = 1
  hi link cppType	      Type
endif

