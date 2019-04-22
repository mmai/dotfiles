" -------------------------------------
"              Coding config
" -------------------------------------

" ----------- Syntax checking & fixing
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_linters = {} " Init empty (for use in other config files)
let g:ale_fixers = {}

" let g:ale_echo_msg_format = '[%linter%] %s'

" ----------- Tags bar
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

" Jump to definition with fzf & tags 
" nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

" -----------  Language server protocol
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_useVirtualText = 0 " Don't show messages in window, only in status bar
let g:LanguageClient_serverCommands = {} " Init empty (for use in other config files)
"
" ----------- Autocompleting
set completeopt+=longest
" Don't open split window with preview
set completeopt-=preview 

" Supress the annoying completion messages
set shortmess+=c

" conceal markers
if has('conceal')
  set conceallevel=2
  " set concealcursor=niv " conceal also on current line on n, i, v modes
endif

" deoplete + neosnippet + autopairs changes
let g:AutoPairsMapCR=0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Expand function prototype
let g:neosnippet#enable_completed_snippet = 1

" fix E764 AutoComplPop error message when editing html files
augroup autocompl_error
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
augroup END

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
augroup autopair
  au Filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
augroup END

" --------------- Formating
" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1

" Tabulation (defaults from base.vim : 2 spaces)
augroup tabulation_languages
  autocmd Filetype python setlocal ts=4 sts=4 sw=4
  autocmd Filetype html setlocal ts=2 sts=2 sw=2
augroup END
