"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
"Defaults everyone can agree on
NeoBundle 'tpope/vim-sensible'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

"--------- File navigation
"CTRL-P (fuzzy finder)
NeoBundle 'kien/ctrlp.vim'
"CTRL-P : jump to functions definitions
NeoBundle 'tacahiroy/ctrlp-funky'
"CTRL-p : show git modified files
NeoBundle 'jasoncodes/ctrlp-modified.vim'


NeoBundle 'bling/vim-airline'
NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'hsitz/VimOrganizer'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'utl.vim'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'dhruvasagar/vim-vinegar'

NeoBundle 'tomtom/tcomment_vim'
"must be before vim-markdown
NeoBundle 'godlygeek/tabular'

"Languages support
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'plasticboy/vim-markdown'

"Check code syntax
NeoBundle 'scrooloose/syntastic'

NeoBundle 'lukaszb/vim-web-indent'
NeoBundle 'indenthtml.vim'
NeoBundle 'vim-scripts/IndentAnything'
NeoBundle 'AutoComplPop'
NeoBundle 'kana/vim-smartinput'

NeoBundle 'mattn/webapi-vim'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'alterc/vim-colors-solarized'


"Disable caps-lock when leaving insert mode (only on Xwindows)
NeoBundle 'suxpert/vimcaps'
NeoBundle 'mattn/gist-vim'
"Bundle 'mmai/wikilink'
NeoBundle 'mmai/vim-markdown-wiki'
NeoBundle 'mmai/vim-scrum-markdown'
NeoBundle 'mmai/vim-zenmode'
" send text to tmux
NeoBundle 'xaviershay/tslime.vim'
" three way merge
NeoBundle 'sjl/splice.vim'
"Bundle 'astashov/vim-ruby-debugger'

"Bundle 'airblade/vim-gitgutter' "too slow

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

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
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype php setlocal ts=2 sts=2 sw=2

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

"Syntax highlighting for embeded elixir templates (similar to .erb)
au BufNewFile,BufRead *.eex setfiletype eruby

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

" Tabulation
"       shortcuts
if exists(":Tabularize")
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
endif
"       auto tabulate |
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"end tabulation

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
