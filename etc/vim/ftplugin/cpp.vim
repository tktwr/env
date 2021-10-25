"
" for c & c++
"
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setl nowrap
setl tabstop=4
setl softtabstop=4
setl shiftwidth=4
setl cindent
"setl keywordprg=man

command -buffer -nargs=* CC  !$MY_CXX $MY_CXXFLAGS <args> % $MY_LDFLAGS
"command -buffer          A   call EditAltSrc()

" insert mode completion (tags)
inoremap <buffer> <C-]>    <C-X><C-]>
" insert mode completion (definitions or macros)
inoremap <buffer> <C-D>    <C-X><C-D>

" abbrebiations
iabclear
if 1
  iabbr #D     #define
  iabbr #I     #include
  iabbr IF     if () {<CR>}<ESC>%F(
  iabbr ELIF   else if () {<CR>}<ESC>%F(
  iabbr EL     else {<CR>}<ESC>%
  iabbr FOR    for (int i=0; i<3; i++) {<CR>}<ESC>%F(
  iabbr FORJ   for (int j=0; j<3; j++) {<CR>}<ESC>%F(
  iabbr FORJI  for (j=0; j<nj; j++) {<CR>for (i=0; i<ni; i++) {<CR>}<CR>}<ESC>%F(
  iabbr FORKJI for (k=0; k<nk; k++) {<CR>for (j=0; j<nj; j++) {<CR>for (i=0; i<ni; i++) {<CR>}<CR>}<CR>}<ESC>%F(
  iabbr FORYX  for (y=0; y<ny; y++) {<CR>for (x=0; x<nx; x++) {<CR>}<CR>}<ESC>%F(
  iabbr FORZYX for (z=0; z<nz; z++) {<CR>for (y=0; y<ny; y++) {<CR>for (x=0; x<nx; x++) {<CR>}<CR>}<CR>}<ESC>%F(
  iabbr WH     while () {<CR>}<ESC>%F(
  iabbr SW     switch () {<CR>}<ESC>%ocase '':<CR>break;<CR>default:<CR>break;<ESC>+%F(
  iabbr CL     class ClassName {<CR>public:<CR>private:<CR>};<ESC>h%
  iabbr ST     struct StructName {<CR>};<ESC>h%
  iabbr EN     enum EnumName {<CR>};<ESC>h%
  iabbr FUNC   void func_name() {<CR>}<ESC>%F(

  iabbr SEP=   //=========================================================================<ESC>^
  iabbr SEP-   //-------------------------------------------------------------------------<ESC>^

  iabbr COUT   std::cout << " : " << x << std::endl;<ESC>0f"
  iabbr <<;;   << std::endl << std::flush;
  iabbr <<;    << std::endl;
endif

iabbr GLb     GLbyte
iabbr GLs     GLshort
iabbr GLi     GLint
iabbr GLf     GLfloat
iabbr GLd     GLdouble
iabbr GLub    GLubyte
iabbr GLus    GLushort
iabbr GLui    GLuint

iabbr glB     glBegin(GL_);<CR>glEnd();<ESC>-t)a

iabbr glTf    glTranslatef(0, 0, 0);<ESC>F(
iabbr glRf    glRotatef(angle, 0, 0, 0);<ESC>F(
iabbr glSf    glScalef(1, 1, 1);<ESC>F(
iabbr glC3f   glColor3f(0, 0, 0);<ESC>F(
iabbr glC4f   glColor4f(0, 0, 0, 0);<ESC>F(
iabbr glV2f   glVertex2f(0, 0);<ESC>F(
iabbr glV3f   glVertex3f(0, 0, 0);<ESC>F(
iabbr glV4f   glVertex4f(0, 0, 0, 0);<ESC>F(
iabbr glT2f   glTexCoord2f(0, 0);<ESC>F(
iabbr glT3f   glTexCoord3f(0, 0, 0);<ESC>F(
iabbr glN3f   glNormal3f(0, 0, 0);<ESC>F(
iabbr glC3fv  glColor3fv();<ESC>F(
iabbr glC4fv  glColor4fv();<ESC>F(
iabbr glV2fv  glVertex2fv();<ESC>F(
iabbr glV3fv  glVertex3fv();<ESC>F(
iabbr glV4fv  glVertex4fv();<ESC>F(
iabbr glT2fv  glTexCoord2fv();<ESC>F(
iabbr glT3fv  glTexCoord3fv();<ESC>F(
iabbr glN3fv  glNormal3fv();<ESC>F(
