
" default spelling languages
set spelllang=fr,en_us

if exists("g:loaded_vimrc") || &cp
  finish
else
  let g:loaded_vimrc = 1
end

"" Basics

" Disable strange Vi defaults.
set nocompatible

" Turn on filetype plugins (:help filetype-plugin).
if has('autocmd')
  filetype plugin indent on
endif

" Enable syntax highlighting.
if has('syntax')
  syntax enable
endif

" Prevent the disturbing highlighting of the matched {([ ])}
let loaded_matchparen = 1

" Disable Alt key for accessing menu (conflict with yankstack Alt+P shortcut)
set winaltkeys=no 

" Sync the last copy register with the system clipboard 
set clipboard^=unnamed,unnamedplus 

if has('nvim')
  " exit neovim terminal
  tnoremap <Esc> <C-\><C-n>
endif

" Allow backspace in insert mode.
set backspace=indent,eol,start

" Disable octal format for number processing.
set nrformats-=octal

" Allow for mappings including `Esc`, while preserving
" zero timeout after pressing it manually.
set ttimeout
set ttimeoutlen=100

" Always show window statuses, even if there's only one.
set laststatus=2

" Show the line and column number of the cursor position.
set ruler

" Show the size of block one selected in visual mode.
set showcmd

" Autoindent when starting new line, or using `o` or `O`.
set autoindent

" Use 'shiftwidth' when using `<Tab>` in front of a line.
" By default it's used only for shift commands (`<`, `>`).
set smarttab

" Indent using two spaces.
set tabstop=2
set shiftwidth=2
set expandtab

" Autocomplete commands using nice menu in place of window status.
" Enable `Ctrl-N` and `Ctrl-P` to scroll through matches.
set wildmenu
set wildmode=longest,full " For autocompletion, complete as much as you can.
set infercase " Choose correct case on autocompletion
set complete-=i " Don't scan included files. The .tags file already does it

" Force utf-8 encoding
set encoding=utf-8

" Set default whitespace characters when using `:set list`
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Search upwards for tags file instead only locally
if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

" Reload unchanged files automatically.
set autoread

" Support all kind of EOLs by default.
set fileformats+=mac

" Increase history size to 1000 items.
set history=1000

" Allow for up to 50 opened tabs on Vim start.
set tabpagemax=50

" Always save upper case variables to viminfo file.
set viminfo^=!

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=% 

" Enable backup and undo files by default.
let s:dir = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let &backupdir = expand(s:dir) . '/backup//'
let &undodir = expand(s:dir) . '/undo//'
set undofile

" Automatically create directories for backup and undo files.
if !isdirectory(expand(s:dir))
  call system("mkdir -p " . expand(s:dir) . "/{backup,undo}")
end


" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" `Ctrl-U` in insert mode deletes a lot. Use `Ctrl-G` u to first break undo,
" so that you can undo `Ctrl-U` without undoing what you typed before it.
inoremap <C-U> <C-G>u<C-U>

" Avoid problems with fish shell
" ([issue](https://github.com/tpope/vim-sensible/issues/50)).
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

"" Extras

" Keep 8 lines above or below the cursor when scrolling.
set scrolloff=8

" Keep 15 columns next to the cursor when scrolling horizontally.
set sidescroll=1
set sidescrolloff=15

" Set minimum window size to 79x5.
set winwidth=79
set winheight=5
set winminheight=5

" If opening buffer, search first in opened windows.
set switchbuf=usetab

" Hide buffers instead of asking if to save them.
set hidden

" Wrap lines by default
set wrap linebreak
set showbreak=" "

" When 'wrap' is on, display last line even if it doesn't fit.
set display+=lastline

" Allow easy navigation between wrapped lines.
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" Keep flags when repeating last substitute command.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Show line numbers on the sidebar.
set number

" ...but not on terminal buffers
au TermOpen * setlocal nonumber norelativenumber

" prevent Tnew to replace current buffer
let g:neoterm_default_mod='belowright'

" Disable any annoying beeps on errors.
set noerrorbells
set visualbell

" Don't parse modelines (google "vim modeline vulnerability").
set nomodeline

" Do not fold by default. But if, do it up to 3 levels.
set foldmethod=indent
set foldnestmax=3
set nofoldenable
" set foldcolumn=2 " show fold info (add a gutter) and enable mouse folding
" See ./styles.vim for colors overriding wombat
" Overrides folded lines text :
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Enable mouse for scrolling and window resizing.
set mouse=a

" Enable right click -> popup
set mousemodel=popup_setpos " do not work ?

" Disable swap to prevent annoying messages.
set noswapfile

" Save up to 100 marks, enable capital marks.
set viminfo='100,f1

" ----- Searching 
" Enable search highlighting.
set hlsearch
" Enable highlighted case-insensitive incremential search.
set incsearch
" Ignore case when searching.
set ignorecase
" Don't ignore case when search has capital letter
" (although also don't ignore case by default).
set smartcase

" Show mode in statusbar, not separately.
set noshowmode

" Add gems.tags to files searched for tags.
set tags+=gems.tags

" Disable output, vcs, archive, rails, temp and backup files.
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*.swp,*~,._*

" Visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]

" Expand %% to path of current buffer in command mode.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enable saving by `Ctrl-s`
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>

" Use Q to intelligently close a window
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer.
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif
  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>

" Set window title by default.
set title

" Always focus on splited window.
set splitright
set splitbelow

" Don't display the intro message on starting Vim.
set shortmess+=I

" Use Silver Searcher for CtrlP plugin (if available)
" Fallback to git ls-files for fast listing.
" Because we use fast strategies, disable caching.
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'cd %s && ag -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git',
    \ 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f' ]
endif

" Accept CtrlP selections also with <Space>
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<Space>', '<CR>', '<2-LeftMouse>'],
  \ }

" Make sure pasting in visual mode doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Prevent common mistake of pressing q: instead :q
map q: :q

" Make a simple "search" text object.
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
" It allows for replacing search matches with cs and then /././.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" ------ NERDTree config (cf. https://github.com/ryanoasis/vim-devicons/issues/248#issuecomment-447057991)
let NERDTreeChDirMode=2 " change current directory when setting new root directory
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" Disable arrow icons at the left side of folders for NERDTree.
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
highlight! link NERDTreeFlags NERDTreeDir

" Automatically close vim if only NERDTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" " returns true iff is NERDTree open/active
" function! IsNTOpen()        
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
"
" " calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
" function! SyncNTTree()
"   if &modifiable && IsNTOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction
"
" autocmd BufEnter * call SyncNTTree()
