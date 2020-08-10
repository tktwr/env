if exists("did_install_my_menu")
  finish
endif
let did_install_my_menu = 1

menu Plugin.IDE        :MyIDE<CR>
menu Plugin.NERDTree   :NERDTreeToggle<CR>
menu Plugin.Tagbar     :TagbarToggle<CR>
menu Plugin.Gstatus    :MyGstatusToggle<CR>
menu Plugin.Ggrep      :Ggrep -I <cword> -- ':!*.dat'<CR>
menu Plugin.GV         :GV --all<CR>
menu Plugin.Trans      :Trans<CR>
menu Plugin.Quit       :confirm qall<CR>

menu Edit.Tab          :Tab /\|<CR>
menu Edit.Tab\ /=      :Tab /=<CR>
menu Edit.Tab\ /:      :Tab /:<CR>
menu Edit.Tab\ /,      :Tab /,<CR>

menu Doc.Memo          :Memo 
menu Doc.Man           :Ref man 
menu Doc.Pydoc         :Ref pydoc 
menu Doc.MyCheckEnv    :MyCheckEnv<CR>

menu Run.Explorer      :RunExplorer<CR>
menu Run.Gvim          :RunGvim<CR>
menu Run.Vscode        :RunVscode<CR>
menu Run.Chrome        :RunChrome<CR>
menu Run.Firefox       :RunFirefox<CR>

menu View.Number       :set invnumber<CR>:set invlist<CR>
menu View.Fold         zi
menu View.GitGutter    :GitGutterToggle<CR>

