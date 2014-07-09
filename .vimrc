" Vundle config
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"Defaults everyone can agree on
Bundle 'tpope/vim-sensible'

"--------- File navigation
"CTRL-P (fuzzy finder)
Bundle 'kien/ctrlp.vim'
"CTRL-P : jump to functions definitions
Bundle 'tacahiroy/ctrlp-funky'
"CTRL-p : show git modified files
Bundle 'jasoncodes/ctrlp-modified.vim'

Bundle 'bling/vim-airline'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'mattn/emmet-vim'
Bundle 'hsitz/VimOrganizer'
Bundle 'chrisbra/NrrwRgn'
Bundle 'utl.vim'
Bundle 'tpope/vim-speeddating'
Bundle 'dhruvasagar/vim-vinegar'

Bundle 'tomtom/tcomment_vim'

"Check code syntax
Bundle 'scrooloose/syntastic'

Bundle 'indenthtml.vim'
Bundle 'vim-scripts/IndentAnything'
Bundle 'AutoComplPop'
Bundle 'kana/vim-smartinput'

"Languages support
Bundle 'elixir-lang/vim-elixir'
Bundle 'wavded/vim-stylus'
Bundle 'alterc/vim-colors-solarized'
Bundle 'kchmck/vim-coffee-script'

Bundle 'mattn/webapi-vim'
Bundle 'kana/vim-textobj-lastpat'
Bundle 'kana/vim-textobj-user'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'
Bundle 'sjl/gundo.vim'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'plasticboy/vim-markdown'

"Disable caps-lock when leaving insert mode (only on Xwindows)
Bundle 'suxpert/vimcaps'
Bundle 'mattn/gist-vim'
Bundle 'mmai/wikilink'
Bundle 'mmai/vim-zenmode'
" send text to tmux
Bundle 'xaviershay/tslime.vim'
" three way merge
Bundle 'sjl/splice.vim'
"Bundle 'astashov/vim-ruby-debugger'

"Bundle 'airblade/vim-gitgutter' "too slow
"End vundle config

set background=dark
"colorscheme solarized
colorscheme desert

set guioptions-=T "No toolbar
set mouse=a "Activate mouse on console mode
"Disable Alt key for accessing menu (conflict with yankstack Alt+P shortcut)
set winaltkeys=no 

"Place temporary files in a specified directory instead of in the current
"directory
set backup " tell vim to keep backup files in a 
set backupdir=/tmp " tell vim where to put its backup files
set dir=/tmp " tell vim where to put swap files

set wildmode=list:longest,full

syntax on
set showmatch

set number

set hlsearch
set tags=./tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)

set expandtab       " Use spaces instead of tabs
" set tabstop=4       " Display \t as 4 spaces
" set shiftwidth=4    " Number of spaces to use for each indent
" set softtabstop=4   " Treat 4 spaces as a tab for editing purposes

let mapleader = "," " Redéfinit la touche <Leader> à ',' au lieu de '\'
let maplocalleader = "_" " Redéfinit la touche <LocalLeader> à '_'

" ,cd => change directory to the file being edited
nnoremap ,cd :cd %:p:h<CR>:pwd<CR> 

"Git 
cnoreabbrev tig Extradite

" Recherche globale, on ne regarde pas dans les répertoires subversion
set grepprg=grep\ -nH\ --exclude-dir\ .svn\ $*

"Syntax highlighting for CakePHP thtml and ctp files
au BufNewFile,BufRead *.thtml setfiletype php
au BufNewFile,BufRead *.ctp setfiletype php

"Syntax highlighting for javascript processing templates
au BufNewFile,BufRead *.pjs setfiletype javascript

" Navigation dans la librairie python
" Penser à executer ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
set tags+=$HOME/.vim/tags/python.ctags
" Complétion pour python
autocmd FileType python set omnifunc=pythoncomplete#Complete
" accès à la complétion par CTRL+Space au lieu de CTRL+X,CTRL+O
inoremap <C-space> <C-x><C-o>

" this lets us put the marker in the file so that
" it can be shared across and stored in version control.
set foldmethod=marker
"unfolded by default
au BufWinEnter * normal zR 


" this is for python, put
" # name for the folded text # {{{
" to begin marker and
" # }}}
" close to end it.
set commentstring=\ #\ %s

" Show file encoding in the status line
if has("statusline")
 "git branch in status line
 set laststatus=2
 "%{GitBranch()} 
 set statusline=%<%f\ [%{GitBranch()}]\ wc:%{WordCount()}\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

"------CTRLP
"ignore node_modules folders
let g:ctrlp_custom_ignore = '\v[\/]node_modules'

"show git modified files in ctrlp
nnoremap <leader>m :CtrlPModified<cr>

" show functions definitions
let g:ctrlp_extensions = ['funky']
nnoremap <leader>fu :CtrlPFunky<cr>
" narrow the list down with a word under cursor
nnoremap <leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<cr>
"------- /CTRLP

"Easy .vimrc editing 
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"ESC remap
inoremap kj <esc>
inoremap KJ <esc>
"inoremap <esc> <nop>

"Disable Ex mode
nnoremap Q <nop>

nnoremap <leader>u :GundoToggle<cr>

"Syntastic
" php 
"let g:syntastic_phpmd_disable=1 "disable phpmd (php mess detector) syntax checking
let g:syntastic_phpcs_disable=1 "disable phpcs (coding standards) syntax checking
"disable syntastic by default (call SyntasticToogleMode to enable)
let g:syntastic_mode_map= {"mode": "passive", "active_filetypes":[], "passive_filetypes": []}

" NERDTree change le répertoire courant (CWD) quand on lui spécifie un 
" nouveau root directory
let NERDTreeChDirMode=2 

" vim-airline
let g:airline_powerline_fonts = 1

"Powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ for\ Powerline
"let Powerline_symbols = 'fancy'
"source $HOME/.vim/powerline/powerline/ext/vim/source_plugin.vim
"source $HOME/.vim/powerline/powerline/bindings/vim/plugin/powerline.vim

let g:languagetool_jar= '/usr/local/LanguageTool/LanguageTool.jar'

" Viki
let g:vikiNameSuffix=".viki"
autocmd! BufRead,BufNewFile $HOME/viki/* set filetype=viki
let g:vikiHomePage =$HOME . "/viki/home"

" VimOrganizer
au BufNewFile,BufRead *.org	set filetype=org
let g:org_command_for_emacsclient='emacsclient'

"Zenmode
let g:zenmode_background = "dark"
let g:zenmode_colorscheme = "solarized"
let g:zenmode_font ="Cousine 12"
let g:zenmode_spell ="fr" "correction orthographique
