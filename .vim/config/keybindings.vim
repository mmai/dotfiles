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

nnoremap <leader>u :UndotreeToggle<cr>
nnoremap <leader>t :TagbarToggle<CR>

" Snippets
nnoremap <leader>dt "=strftime("%Y-%m-%d %H:%M:%S")<CR>P

" Sidemenu shortcuts
nmap <Leader>m <Plug>(sidemenu)
xmap <Leader>m <Plug>(sidemenu-visual)

" incsearch plugin shortcuts
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" accès à la complétion par CTRL+Space au lieu de CTRL+X,CTRL+O
inoremap <C-space> <C-x><C-o>

"--------------- PHP ----------------------
" PHP :: namespaces shortcuts
autocmd FileType php inoremap <Leader>pnu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pnu :call PhpInsertUse()<CR>
autocmd FileType php inoremap <Leader>pne <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pne :call PhpExpandClass()<CR>
 
" PHP :: phpcd shortcuts
silent! nnoremap <silent> <unique> <buffer> <leader>pdr 
			\ :<C-u>call phpcd#JumpToDefinition('normal')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pd
			\ :<C-u>call phpcd#JumpToDefinition('split')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pdv
			\ :<C-u>call phpcd#JumpToDefinition('vsplit')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pb :call phpcd#JumpBack()<CR>