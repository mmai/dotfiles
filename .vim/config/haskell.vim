" Haskell

let g:LanguageClient_serverCommands.haskell = ['hie', '--lsp']

" Indenting on save is too aggressive for me
let g:hindent_on_save = 0

" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" ----- Linter w0rp/ale -----
let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint']

" ----- parsonsmatt/intero-neovim -----
let g:intero_start_immediately = 1
let g:intero_use_neomake = 0 " Use ALE (works even when not using Intero)

augroup interoReload
  " Reload the file in Intero after saving
  autocmd BufWritePost *.hs silent InteroReload
augroup END

let g:haskellmode_completion_ghc = 0 "Disable haskell-vim omnifunc
let g:neomake_haskell_enabled_makers = [] " 'hlint']

" let g:haskell_indent_if = 3
" let g:haskell_indent_case = 5
" let g:haskell_indent_let = 4
" let g:haskell_indent_do = 3
" let g:haskell_indent_in = 1
" let g:haskell_indent_guard = 4

" let g:haskell_tabular = 1

" Do conceals of wide stuff, like ::, forall, =>, etc.
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1

" -------- Tagbar
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

let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻"

" " Generate haskell tags with codex and hscope
" map <leader>tg :!codex update --force<CR>:call system("git hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>
"
" set csprg=~/.vim/haskell-vim-now/bin/hscope
" set csto=1 " search codex tags first
" set cst
" set csverb
" nnoremap <silent> <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
"
" " Automatically make cscope connections
" function! LoadHscope()
"   let db = findfile("hscope.out", ".;")
"   if (!empty(db))
"     let path = strpart(db, 0, match(db, "/hscope.out$"))
"     set nocscopeverbose " suppress 'duplicate connection' error
"     exe "cs add " . db . " " . path
"     set cscopeverbose
"   endif
" endfunction
" au BufEnter /*.hs call LoadHscope()
 
