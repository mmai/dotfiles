" source $VIMRUNTIME/menu.vim
let s:cpo_save = &cpo
set cpo&vim

" Project
an 10.310 &Project.&Tag\ Outline	:TagbarToggle<CR>
an 10.320 &Project.&Quickfix	:copen<CR>
an 10.325 &Project.&Go\ to\ &definition	:call LanguageClient_textDocument_definition()<CR>
an 10.400 &Project.Reformat\ code	:call LanguageClient_textDocument_formatting()<CR>
an 10.410 &Project.Show\ references	:call LanguageClient_textDocument_references()<CR>
an 10.420 &Project.Show\ info	:call LanguageClient_textDocument_hover()<CR>
an 10.430 &Project.Rename	:call LanguageClient_textDocument_rename()<CR>

" Files
an 20.100 &Files.éBuffers	:Buffers<CR>
an 20.110 &Files.Save\ as\ &root	:w !sudo tee % >/dev/null<CR>
an 20.310 &Files.&Find\ files	:Files<CR>
an 20.320 &Files.&Search	:Ag<CR>
an 20.410	Files.Find\ word\ under\ cursor\ in\ files\ [,fa] ,fa
an 20.420	Files.Find\ and\ replace\ [,fr] ,fr

" Writing
an 30.110 &Writing.&Distraction\ free\ writing :Goyo<CR>
an 30.310 &Writing.Preview\ &markdown	:LivedownToggle<CR>
an 30.320 &Writing.Toggle\ &spelling	:setlocal spell! spelllang=fr,en_us<CR>

" System
an 40.110 &System.&Check\ health :CheckHealth<CR>
an 40.310 &System.&Error\ messages :messages<CR>


" Restore the previous value of 'cpoptions'.
let &cpo = s:cpo_save
unlet s:cpo_save

" source $VIMRUNTIME/menu.vim
" Make sure the '<' and 'C' flags are not included in compatible options 'cpoptions', otherwise <CR> would not be recognized.  
set cpo-=<
set wcm=<C-Z>
