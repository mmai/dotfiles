" Vundle config
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'nelstrom/vim-visual-star-search'
Bundle 'mattn/zencoding-vim'
Bundle 'hsitz/VimOrganizer'
Bundle 'chrisbra/NrrwRgn'
Bundle 'utl.vim'
Bundle 'tpope/vim-speeddating'
Bundle 'wincent/Command-T'
Bundle 'scrooloose/syntastic'
Bundle 'AutoComplPop'
Bundle 'kana/vim-smartinput'
Bundle 'mattn/webapi-vim'
Bundle 'kana/vim-textobj-lastpat'
Bundle 'kana/vim-textobj-user'
Bundle 'YankRing.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'
Bundle 'sjl/gundo.vim'
Bundle 'hynek/vim-python-pep8-indent'

Bundle 'altercation/vim-colors-solarized'


Bundle 'mattn/gist-vim'
Bundle 'kchmck/vim-coffee-script'
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

"Place temporary files in a specified directory instead of in the current
"directory
set backup " tell vim to keep backup files in a 
set backupdir=/tmp " tell vim where to put its backup files
set dir=/tmp " tell vim where to put swap files

set wildmenu "display completion alternatives
set wildmode=list:longest,full

filetype plugin indent on
syntax on
set number

set hlsearch
set incsearch
set tags=./tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)

runtime! macros/matchit.vim " Load matchit (% to bounce from do to end, etc.)

set expandtab       " Use spaces instead of tabs
set autoindent      " Inherit indent from previous line
set tabstop=4       " Display \t as 2 spaces
set shiftwidth=4    " Number of spaces to use for each indent
set softtabstop=4   " Treat 2 spaces as a tab for editing purposes
set smarttab        " Insert blank space at beginning of line with tabs

let mapleader = "," " Redéfinit la touche <Leader> à ',' au lieu de '\'
let maplocalleader = "_" " Redéfinit la touche <LocalLeader> à '_'

" ,cd => change directory to the file being edited
nnoremap ,cd :cd %:p:h<CR>:pwd<CR> 

"traite tous les nombre en décimal
set nrformats=

"Git 
cnoreabbrev tig Extradite

" NERDTree change le répertoire courant (CWD) quand on lui spécifie un 
" nouveau root directory
let NERDTreeChDirMode=2 

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
" this is for python, put
" # name for the folded text # {{{
" to begin marker and
" # }}}
" close to end it.
set commentstring=\ #\ %s

" Viki
let g:vikiNameSuffix=".viki"
autocmd! BufRead,BufNewFile $HOME/viki/* set filetype=viki
let g:vikiHomePage =$HOME . "/viki/home"

" Show file encoding in the status line
if has("statusline")
 "git branch in status line
 set laststatus=2
 "%{GitBranch()} 
 set statusline=%<%f\ [%{GitBranch()}]\ wc:%{WordCount()}\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

"Easy .vimrc editing 
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap kj <esc>
"inoremap <esc> <nop>
nnoremap <leader>u :GundoToggle<cr>

"Syntastic
" php 
"let g:syntastic_phpmd_disable=1 "disable phpmd (php mess detector) syntax checking
let g:syntastic_phpcs_disable=1 "disable phpcs (coding standards) syntax checking

"Powerline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ for\ Powerline
let Powerline_symbols = 'fancy'
source $HOME/.vim/powerline/powerline/ext/vim/source_plugin.vim

let g:languagetool_jar= '/usr/local/LanguageTool/LanguageTool.jar'

" VimOrganizer
au BufNewFile,BufRead *.org	set filetype=org
let g:org_command_for_emacsclient='emacsclient'

"Zenmode
let g:zenmode_background = "dark"
let g:zenmode_colorscheme = "solarized"
let g:zenmode_font ="Cousine 12"
let g:zenmode_spell ="fr" "correction orthographique
