"
" for tex
"
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

iabclear
iabbr EQ    \[ \]<ESC>F[a
iabbr FRAC  \frac{}{}<ESC>2F{
iabbr PAR   \partial
iabbr VEC   \vec{}<ESC>F{
iabbr IMG   \begin{figure}[htbp]<CR>  \centering<CR>  \includegraphics[width=.4\hsize]{eps/.eps}<CR>  \caption{}<CR>  \label{img:}<CR>\end{figure}<ESC>
iabbr TAB   \begin{table}<CR>  \centering<CR>  \begin{tabular}[htbp]{\|l\|c\|r\|}<CR>  \hline<CR>  a & b & c \\<CR>  \hline<CR>  1 & 2 & 3 \\<CR>  \hline<CR>  \end{tabular}<CR>  \caption{}<CR>  \label{tab:}<CR>\end{table}<ESC>

