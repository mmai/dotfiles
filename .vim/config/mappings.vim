"--------------------------- keybindings / shortcuts

" To show all mappings, including those defined by plugins, and where they are defined : 
" :Verbose map
" or replace map with one of the following:
"   nmap - Display normal mode maps
"   imap - Display insert mode maps
"   vmap - Display visual and select mode maps
"   smap - Display select mode maps
"   xmap - Display visual mode maps
"   cmap - Display command-line mode maps
"   omap - Display operator pending mode maps

let mapleader = "," "      Set <Leader> key to ',' instead of '\'
let g:mapleader = "," "    Set <Leader> key to ',' instead of '\'
let maplocalleader = "_" " Set <LocalLeader> to '_'

" Use `Ctrl-L` to clear the highlighting of :set hlsearch.
nnoremap <C-l> :nohlsearch<CR>

"ESC remap
inoremap kj <esc>
inoremap KJ <esc>
inoremap jk <esc>
inoremap JK <esc>

"Easy vimrc editing 
nnoremap <leader>ev :vsplit $HOME/.vim/vimrc<cr>
nnoremap <leader>sv :source $HOME/.vim/vimrc<cr>

" ,cd => change directory to the file being edited
nnoremap ,cd :cd %:p:h<CR>:pwd<CR> 

nnoremap <leader>u  :UndotreeToggle<cr>
nnoremap <leader>tt  :TagbarToggle<CR>
" Toggle file explorer
nnoremap <leader>fe :NERDTreeToggle<cr>

" Save with sudo
cmap W!! w !sudo tee % >/dev/null

" Sidemenu shortcuts
" nmap <Leader>m <Plug>(sidemenu)
" xmap <Leader>m <Plug>(sidemenu-visual)

nmap <Leader>m :emenu <C-Z>


" incsearch plugin shortcuts
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Global replace
nnoremap <leader>fr :Far search replace **/*files.hs
" Global search for word under cursor
nnoremap <leader>fa :Ag <C-r><C-w>

" ----------- Snippets
nnoremap <leader>dt "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" ----------- AutoCompletion
" complete with CTRL+Space instead of CTRL+X,CTRL+O
inoremap <C-space> <C-x><C-o>

" Complete with tab key
imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
" imap <expr><CR> pumvisible() ? "\<C-e>" : "\<CR>\<Plug>AutoPairsReturn"

"--------------- Personal wiki ----------------
" open ~/think/index.md
nnoremap <leader>kk :e ~/think/index.md<cr>

"--------------- Language server client ----------------------
nnoremap <silent> <Leader>lsh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>lsd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Leader>lst :call LanguageClient_textDocument_typeDefinition()<CR>
nnoremap <silent> <Leader>lsi :call LanguageClient_textDocument_implementation()<CR>
nnoremap <silent> <Leader>lsf :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <Leader>lsr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Leader>lsw :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <Leader>lsc :call LanguageClient_contextMenu()<CR>

"--------------- Testing ----------------------
nnoremap <Leader>tf :TestFile<CR>
nnoremap <Leader>tl :TestLast<CR>
nnoremap <Leader>tn :TestNearest<CR>
nnoremap <Leader>ts :TestSuite<CR>
nnoremap <Leader>tv :TestVisit<CR>

