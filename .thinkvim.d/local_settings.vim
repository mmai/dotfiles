" --------------------------------------------------
" -----------------  General config ----------------
" --------------------------------------------------
" Keep 8 lines above or below the cursor when scrolling.
set scrolloff=8

" Keep 15 columns next to the cursor when scrolling horizontally.
set sidescrolloff=15

" Disable archive, rails, temp and backup files.
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" --------------------------------------------
" -----------------  Mappings ----------------
" --------------------------------------------
" Prevent common mistake of pressing q: instead :q
map q: :q

"ESC remap
inoremap kj <esc>
inoremap KJ <esc>
inoremap jk <esc>
inoremap JK <esc>

"Easy config editing 
nnoremap <leader>ev :vsplit $HOME/.thinkvim.d/local_settings.vim<cr>
nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<cr>
