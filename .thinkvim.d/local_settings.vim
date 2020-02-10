" --------------------------------------------------
" -----------------  General config ----------------
" --------------------------------------------------
" Enable mouse for scrolling and window resizing.
set mouse=a

" Keep 8 lines above or below the cursor when scrolling.
set scrolloff=8

" Keep 15 columns next to the cursor when scrolling horizontally.
set sidescrolloff=15

" Disable archive, rails, temp and backup files.
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" --------------------- Settings overrides ---
" Disable Highlight symbol under cursor on CursorHold (defined in config.vim)
autocmd! CursorHold

" Disable Highlight or current line
set nocursorline

" --------------------------------------------------
" --------------------- Plugins config--------------
" --------------------------------------------------
" prevent Tnew to replace current buffer
let g:neoterm_default_mod='belowright'

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

" Expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Easy config editing 
nnoremap <leader>ev :vsplit $HOME/.thinkvim.d/local_settings.vim<cr>
nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<cr>

"--------------- Personal wiki ----------------
" open ~/think/index.md
nnoremap ,kk :e ~/think/index.md<cr>:cd %:p:h<CR>:pwd<CR> 
" Space + Enter : open markdown wiki links in a new split
nnoremap <Space><CR> <C-w>v:MdwiGotoLink<CR>
