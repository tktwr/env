if exists("did_install_my_menu")
  finish
endif
let did_install_my_menu = 1

menu MyPlugin.NERDTree   :MyNERDTreeToggle<CR>
menu MyPlugin.Gstatus    :MyGstatusToggle<CR>
menu MyPlugin.Ggrep      :Ggrep -I <cword> -- ':!*.dat'<CR>
menu MyPlugin.GV         :GV --all<CR>
menu MyPlugin.Trans      :Trans<CR>
menu MyPlugin.Quit       :confirm qall<CR>

menu MyRun.Explorer      :RunExplorer<CR>
menu MyRun.Gvim          :RunGvim<CR>
menu MyRun.Vscode        :RunVscode<CR>
menu MyRun.Chrome        :RunChrome<CR>
menu MyRun.Firefox       :RunFirefox<CR>

menu MyView.Number       :set invnumber<CR>:set invlist<CR>
menu MyView.Fold         zi
menu MyView.GitGutter    :GitGutterToggle<CR>

