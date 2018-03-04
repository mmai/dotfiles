" ----------------------- Coding config

map <leader>tt :TagbarToggle<CR>
set tags=./tags;tags;/,codex.tags;/ " Recherche le fichier tags (man ctags)  dans le répertoire du fichier
                  " courant puis dans le répertoire parent, etc.
                " Penser à exécuter `ctags -R -h ''.php''` dans le repertoire de base des
                " fichiers à analyser (ajouter --exclude=*.js s'il y a des
                " messages d'erreur liés aux fichiers javascript)

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

let g:phpcd_disable_modifier=0 "PHP (phpcd) utilisation avec neosnippet

"Syntastic
" IDE command : enable syntastic,...
nnoremap <leader>ide :SyntasticToggleMode<cr>  
let g:syntastic_always_populate_loc_list=1 "populate location-list with errors : navigate with :lne :lpr
let g:syntastic_mode_map= {"mode": "active", "active_filetypes":[], "passive_filetypes": []} " enable syntastic by default (call SyntasticToggleMode to disable)
"         PHP 
"let g:syntastic_phpmd_disable=1 "disable phpmd (php mess detector) syntax checking
let g:syntastic_phpcs_disable=1 "disable phpcs (coding standards) syntax checking


let g:syntastic_javascript_checkers=['eslint'] 


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

" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
set viminfo^=% " Remember info about open buffers on close

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

" fix E764 AutoComplPop error message when editing html files
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
" accès à la complétion par CTRL+Space au lieu de CTRL+X,CTRL+O
inoremap <C-space> <C-x><C-o>

" this is for python, put
" # name for the folded text # {{{
" to begin marker and
" # }}}
" close to end it.
set commentstring=\ #\ %s
