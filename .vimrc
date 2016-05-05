"TODO ?
"vim-snipmate, neocompletee.vim, nerdcommenter, neocomplete
let mapleader = "," " Redéfinit la touche <Leader> à ',' au lieu de '\'
let g:mapleader = "," " Redéfinit la touche <Leader> à ',' au lieu de '\'
let maplocalleader = "_" " Redéfinit la touche <LocalLeader> à '_'

"prevent the disturbing highlighting of the matched {([ ])}
let loaded_matchparen = 1

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
endif

" Required:
call plug#begin(expand('~/.vim/bundle'))

" Add or remove your Bundles here:
"Defaults everyone can agree on
Plug 'tpope/vim-sensible'

Plug 'Shougo/vimproc.vim', {
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
Plug 'kien/ctrlp.vim'
"CTRL-P : jump to functions definitions
Plug 'tacahiroy/ctrlp-funky'
"CTRL-p : show git modified files
Plug 'jasoncodes/ctrlp-modified.vim'


Plug 'bling/vim-airline'
Plug 'nelstrom/vim-visual-star-search'
Plug 'hsitz/VimOrganizer'
Plug 'chrisbra/NrrwRgn'
Plug 'utl.vim'
Plug 'tpope/vim-speeddating'
Plug 'dhruvasagar/vim-vinegar'

Plug 'mattn/emmet-vim'
"Expand CSS selectors expression to HTML (ie div#page>div.logo+ul#navigation>li*5>a)
"Works on multiline selections. More on documentation.
"On insert mode:
"<C-y>,          : complete abbreviation (don't forget the ',')
"<C-y>n / <C-y>N : go to next/previous edit point 
"<C-y>d          : select element 

Plug 'terryma/vim-multiple-cursors' 
"Like SublimeText multisection
"<C-n> : select current word, then the next...
"<C-p> : cancel selection 
"<C-x> : omit current selection 
"v : go to normal mode and edit
"ESC : back to regular Vim

Plug 'tomtom/tcomment_vim'
"must be before vim-markdown
Plug 'godlygeek/tabular'

"Languages support
Plug 'othree/yajs.vim',{'for':'javascript'}
Plug 'lambdatoast/elm.vim'
Plug 'Quramy/tsuquyomi' "TypeScript completion, refactoring, etc.
Plug 'leafgarland/typescript-vim' "TypeScript
Plug 'heavenshell/vim-jsdoc'
Plug 'elixir-lang/vim-elixir'
Plug 'wavded/vim-stylus'
Plug 'kchmck/vim-coffee-script'
Plug 'hynek/vim-python-pep8-indent'
Plug 'plasticboy/vim-markdown'

"Check code syntax
Plug 'scrooloose/syntastic'

" Plug 'jason0x43/vim-js-indent'
Plug 'gavocanov/vim-js-indent' "works well whith yajs.vim
Plug 'indenthtml.vim'
Plug 'vim-scripts/IndentAnything'
Plug 'AutoComplPop'
Plug 'kana/vim-smartinput'

Plug 'mattn/webapi-vim'
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-user'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'sjl/gundo.vim'
Plug 'alterc/vim-colors-solarized'


"Disable caps-lock when leaving insert mode (only on Xwindows)
Plug 'suxpert/vimcaps'
Plug 'mattn/gist-vim'
"Bundle 'mmai/wikilink'
Plug 'mmai/vim-markdown-wiki'
Plug 'mmai/vim-scrum-markdown'
Plug 'mmai/vim-zenmode'
" send text to tmux
Plug 'xaviershay/tslime.vim'
" three way merge
Plug 'sjl/splice.vim'
"Bundle 'astashov/vim-ruby-debugger'

"Bundle 'airblade/vim-gitgutter' "too slow

" ---- From haskell-vim-now : 
" Plugin 'int3/vim-extradite'
" Plugin 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'moll/vim-bbye'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/gitignore'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/Gundo'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'
" Allow pane movement to jump out of vim into tmux
Plug 'christoomey/vim-tmux-navigator'
" Haskell
Plug 'raichoo/haskell-vim'
Plug 'enomsg/vim-haskellConcealPlus'
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'
" Colorscheme
Plug 'vim-scripts/wombat256.vim'

" Required:
call plug#end()

" Required:
filetype plugin indent on


set background=dark
"colorscheme solarized
colorscheme desert

" {{{ From haskell-vim-now
" Use par for prettier line formatting
set formatprg="PARINIT='rTbgqR B=.,?_A_a Q=_s>|' par\ -w72"

" Use stylish haskell instead of par for haskell buffers
autocmd FileType haskell let &formatprg="stylish-haskell"

" Find custom built ghc-mod, codex etc
let $PATH = $PATH . ':' . expand("~/.vim/haskell-vim-now/bin")

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
try
  colorscheme wombat256mod
catch
endtry

" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" ====== TypeScript
set ballooneval
autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" /End TypeScript

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Use same color behind concealed unicode characters
hi clear Conceal

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0
" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Fuzzy find files
nnoremap <silent> <Leader><space> :CtrlP<CR>
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|node_modules)$' }

" Pretty unicode haskell symbols
let g:haskell_conceal_wide = 1
let g:haskell_conceal_enumerations = 1
let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻"

augroup haskell
  autocmd!
  autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>:SyntasticReset<cr>
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup whitespace
  autocmd!
  autocmd BufWrite *.hs :call DeleteTrailingWS()
augroup END

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" }}}
"
set tags=./tags;tags;/,codex.tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" Generate haskell tags with codex and hscope
map <leader>tg :!codex update --force<CR>:call system("git hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

map <leader>tt :TagbarToggle<CR>

set csprg=~/.vim/haskell-vim-now/bin/hscope
set csto=1 " search codex tags first
set cst
set csverb
nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

" Haskell Interrogation {{{

set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" But provide (neco-ghc) omnicompletion
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>
" Haskell Lint
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle 

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo 

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>

" }}}

" Conversion {{{

function! Pointfree()
  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h. :call Pointfree()<CR>

function! Pointful()
  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
endfunction
vnoremap <silent> <leader>h> :call Pointful()<CR>

" }}}


" }}} From haskell-vim-now

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

set number

set hlsearch

set expandtab       " Use spaces instead of tabs
set smarttab
set shiftwidth=2
set tabstop=2
" set tabstop=4       " Display \t as 4 spaces
" set shiftwidth=4    " Number of spaces to use for each indent
" set softtabstop=4   " Treat 4 spaces as a tab for editing purposes
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype php setlocal ts=2 sts=2 sw=2

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
let g:syntastic_javascript_checkers=['standard'] 
let g:syntastic_always_populate_loc_list=1 "populate location-list with errors : navigate with :lne :lpr
" highlight SyntasticStyleError guibg=Red
" highlight SyntasticStyleWarning guibg=Orange

" let g:syntastic_javascript_checkers=['eslint'] 
"disable syntastic by default (call SyntasticToggleMode to enable)
let g:syntastic_mode_map= {"mode": "passive", "active_filetypes":[], "passive_filetypes": []}

" javascript automatic formatting on save
autocmd bufwritepost *.js silent !standard-format -w %
set autoread

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

" IDE command : enable syntastic,...
nnoremap <leader>ide :SyntasticToggleMode<cr>  

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
