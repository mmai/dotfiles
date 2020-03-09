" --------------------------------------------------
" -----------------  General config ----------------
" --------------------------------------------------
" Enable mouse for scrolling and window resizing.
set mouse=a

" Always focus on splited window.
set splitright
set splitbelow

" Keep 8 lines above or below the cursor when scrolling.
set scrolloff=8

" Keep 15 columns next to the cursor when scrolling horizontally.
set sidescrolloff=15

" Disable archive, rails, temp and backup files.
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" --------------------- Settings overrides ---
set norelativenumber " keep absolute line numbers
set cmdheight=1      " Height of the command line (why did they set it at 2 ?)

" Do not fold by default. But if, do it up to 3 levels.
set foldnestmax=3
set nofoldenable

" Disable Highlight symbol under cursor on CursorHold (defined in config.vim)
autocmd! CursorHold

" Disable Highlight of current line & other unecessary autocmd (core/filetype.vim)
autocmd! user_plugin_filetype

" Disable line numbers in markdown
autocmd FileType markdown setlocal nonumber

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

" overrides layers/+thinkvim/config.vim
if dein#tap('vim-choosewin')
	nmap ù         <Plug>(choosewin)
	nmap <Leader>ù :<C-u>ChooseWinSwapStay<CR>
endif

if dein#tap('vim-vinegar')
    nmap - <Plug>VinegarUp
endif

"ESC remap
inoremap kj <esc>
inoremap KJ <esc>
inoremap jk <esc>
inoremap JK <esc>

" ,cd => change directory to the file being edited
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Easy config editing 
nnoremap <leader>ev :vsplit $HOME/.thinkvim.d/local_settings.vim<cr>
nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<cr>

" Open tig in status mode in the current file directory
nnoremap <leader>gg :T cd %:h && tig status<cr><C-w>ji

" Prompt for a command to run (on tmux)
map <Leader>tg :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand (on tmux)
map <Leader>tr :VimuxRunLastCommand<CR>
" Zoom the tmux runner pane
map <Leader>tz :VimuxZoomRunner<CR>
" lancer tests rust dans vimux ? https://github.com/jtdowney/vimux-cargo

"--------------- Personal wiki shortcuts ----------------
" open ~/think/index.md
nnoremap ,kk :e ~/think/index.md<cr>:cd %:p:h<CR>:pwd<CR> 
" , + Enter : open markdown wiki links in a new split
nnoremap ,<CR> <C-w>v:MdwiGotoLink<CR>
" Go back in history
nnoremap ,, :BufSurfBack<CR>
" Go forward in history
nnoremap ,; :BufSurfForward<CR>
