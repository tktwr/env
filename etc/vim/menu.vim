if exists("did_install_my_menu")
  finish
endif
let did_install_my_menu = 1

menu Plugin.IDE               :MyIDE<CR>
menu Plugin.NERDTree<Tab>F2   :NERDTreeToggle<CR>
menu Plugin.Tagbar            :TagbarToggle<CR>
menu Plugin.Gstatus<Tab>F3    :MyGstatusToggle<CR>
menu Plugin.GV                :GV --all<CR>
menu Plugin.Trans             :Trans<CR>
menu Plugin.Quit              :confirm qall<CR>

menu Edit.GitGrep<Tab>F4      :Ggrep -I <cword> -- ':!*.dat'<CR>
menu Edit.VimGrep             :MyVimGrep <cword><CR>
menu Edit.Tab                 :Tab /\|<CR>
menu Edit.Tab\ /=             :Tab /=<CR>
menu Edit.Tab\ /:             :Tab /:<CR>
menu Edit.Tab\ /,             :Tab /,<CR>

menu Doc.Memo                 :Memo 
menu Doc.Man                  :Ref man 
menu Doc.Pydoc                :Ref pydoc 
menu Doc.CheckEnv             :MyCheckEnv<CR>

menu Run.Explorer             :RunExplorer<CR>
menu Run.Gvim                 :RunGvim<CR>
menu Run.Vscode               :RunVscode<CR>
menu Run.Chrome               :RunChrome<CR>
menu Run.Firefox              :RunFirefox<CR>

menu View.SetTab\ 2           :MySetTab 2<CR>
menu View.SetTab\ 4           :MySetTab 4<CR>
menu View.Number<Tab>--       :MyLineNumberToggle<CR>
menu View.Fold<Tab>==         zi
menu View.GitGutter<Tab>++    :GitGutterToggle<CR>

