" -------------------------------------
"              Coding config
" -------------------------------------

" ----------- Syntax checking & fixing
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_linters = {} " Init empty (for use in other config files)

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

" ----------- Tags bar
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

" Jump to definition with fzf & tags 
" nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

" ----------- Autocompleting
set completeopt+=longest
" Don't open split window with preview
set completeopt-=preview 

" conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" deoplete + neosnippet + autopairs changes
let g:AutoPairsMapCR=0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
imap <expr><TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"

" Expand function prototype
let g:neosnippet#enable_completed_snippet = 1

" fix E764 AutoComplPop error message when editing html files
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci

" " Use buffer words as default tab completion
" let g:SuperTabDefaultCompletionType = '<c-x><c-p>'
"
" " But provide (neco-ghc) omnicompletion
" if has("gui_running")
"   imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
" else " no gui
"   if has("unix")
"     inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
"   endif
" endif

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
