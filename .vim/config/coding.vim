" -------------------------------------
"              Coding config
" -------------------------------------

" ----------- Syntax checking & fixing
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_linters = {} " Init empty (for use in other config files)

" ----------- Tags bar
set tags=./tags;tags;/,codex.tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)

" Navigation dans la librairie python
" Penser à executer ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
set tags+=$HOME/.vim/tags/python.ctags
" Complétion pour python
autocmd FileType python set omnifunc=pythoncomplete#Complete

" ----------- Autocompleting
set completeopt+=longest

" conceal markers
if has('conceal')
  set conceallevel=2
endif

" deoplete + neosnippet + autopairs changes
let g:AutoPairsMapCR=0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"

let g:neosnippet#enable_completed_snippet = 1

" fix E764 AutoComplPop error message when editing html files
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
" accès à la complétion par CTRL+Space au lieu de CTRL+X,CTRL+O
inoremap <C-space> <C-x><C-o>

"PHP (phpcd) utilisation avec neosnippet
let g:phpcd_disable_modifier=0 

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

" Autopair for vim type : don't close the comment string '"'
au Filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}

" --------------- Formating
" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1

" Tabulation (defaults from base.vim : 2 spaces)
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype php setlocal ts=4 sts=4 sw=4

"       auto tabulate '|' sign (<Bar>)
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

" this is for python, put
" # name for the folded text # {{{
" to begin marker and
" # }}}
" close to end it.
set commentstring=\ #\ %s
