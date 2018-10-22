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

syn keyword cppType     uchar ushort uint ulong

syn keyword cppType     std
syn keyword cppType     vector list deque stack queue priority_queue
syn keyword cppType     map multimap set multiset
syn keyword cppType     string array valarray bitset
syn keyword cppType     unique_ptr shared_ptr weak_ptr
syn keyword cppType     ifstream ofstream
syn keyword cppType     istringstream ostringstream

syn keyword cppType     cv
syn keyword cppType     Mat Scalar Point

syn keyword cppType     tt
syn keyword cppType     Vec2i Vec2f
syn keyword cppType     Vec3i Vec3f
syn keyword cppType     Vec4i Vec4f
syn keyword cppType     Color1uc Color1us Color1f
syn keyword cppType     Color3uc Color3us Color3f
syn keyword cppType     Color4uc Color4us Color4f
syn keyword cppType     Image1uc Image1us Image1f
syn keyword cppType     Image3uc Image3us Image3f
syn keyword cppType     Image4uc Image4us Image4f
syn keyword cppType     FileName Array Time

if !exists("did_cpp_syntax_inits")
  let did_cpp_syntax_inits = 1
  hi link cppType	      Type
endif

