"colorscheme darkblue
colorscheme desert

filetype plugin indent on
syntax on
set number
set hlsearch
set mouse=a "Active la souris en mode console
set tags=./tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)

runtime! macros/matchit.vim " Load matchit (% to bounce from do to end, etc.)

set expandtab       " Use spaces instead of tabs
set autoindent      " Inherit indent from previous line
set tabstop=2       " Display \t as 2 spaces
set shiftwidth=2    " Number of spaces to use for each indent
set softtabstop=2   " Treat 2 spaces as a tab for editing purposes
set smarttab        " Insert blank space at beginning of line with tab

let mapleader = "," " Redéfinit la touche <Leader> à ',' au lieu de '\'

" ,cd => change directory to the file being edited
nnoremap ,cd :cd %:p:h<CR>:pwd<CR> 

"Git 
cnoreabbrev tig Extradite

if has("autocmd")
    " Change to the directory the file in your current buffer is in
    " N'est plus pertinent avec NERDTree et la nouvelle config de tags
    "autocmd BufEnter * :cd %:p:h
endif " has("autocmd")

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


python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

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

" Show who commited the selected lines in subversion : select text then type 'gl'
vmap gl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Show file encoding in the status line
if has("statusline")
 "git branch in status line
 set laststatus=2
 "%{GitBranch()} 
 set statusline=%<%f\ [%{GitBranch()}]\ wc:%{WordCount()}\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" Couleurs pour completion (les valeurs par defaut de darkblue sont
" illisibles) : comment faire ?

" pathogen : permet l'installation de plugins dans leurs propres
" répertoires
call pathogen#infect()

