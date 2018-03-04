"--------------------------- keybindings / shortcuts

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

" Snippets
nnoremap <leader>dt "=strftime("%Y-%m-%d %H:%M:%S")<CR>P

" Sidemenu shortcuts
nmap <Leader>m <Plug>(sidemenu)
xmap <Leader>m <Plug>(sidemenu-visual)

" incsearch plugin shortcuts
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
