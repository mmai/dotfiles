" Haskell

nnoremap <leader>hs :%!stylish-haskell<cr>
let g:haskellmode_completion_ghc = 0 "Disable haskell-vim omnifunc
autocmd BufWritePost *.hs silent InteroReload

let g:neomake_haskell_enabled_makers = [] " 'hlint']

" Process management:
nnoremap <Leader>hio :InteroOpen<CR>
nnoremap <Leader>hik :InteroKill<CR>
nnoremap <Leader>hic :InteroHide<CR>
nnoremap <Leader>hil :InteroLoadCurrentModule<CR>
nnoremap <Leader>hif :InteroLoadCurrentFile<CR>
nnoremap <Leader>his :InteroSetTargets<CR>

" REPL commands
nnoremap <Leader>hie :InteroEval<CR>
nnoremap <Leader>hit :InteroGenericType<CR>
nnoremap <Leader>hiT :InteroType<CR>
nnoremap <Leader>hii :InteroInfo<CR>
nnoremap <Leader>hiI :InteroTypeInsert<CR>

let g:intero_start_immediately = 1

" Go to definition:
nnoremap <Leader>hid :InteroGoToDef<CR>

" Highlight uses of identifier:
nnoremap <Leader>hiu :InteroUses<CR>

" Reload the file in Intero after saving
" autocmd! BufWritePost *.hs InteroReload

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 4

let g:haskell_tabular = 1

" Do conceals of wide stuff, like ::, forall, =>, etc.
let g:haskell_conceal_wide = 1
let g:haskell_conceal_bad = 1

let g:haskell_indent_if = 3
let g:haskell_indent_case = 5
let g:haskell_indent_let = 4
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1

setlocal keywordprg=":stack hoogle"

" setlocal formatprg=hindent " from parsonsmatt
" autocmd FileType haskell let &formatprg="stylish-haskell" " from ??
autocmd FileType haskell let &formatprg="hindent"

" -- from ??
let hscoptions="𝐒𝐓𝐄𝐌xRtB𝔻"

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

" Enable some tabular presets for Haskell
let g:haskell_tabular = 1

" Show types in completion suggestions
let g:necoghc_enable_detailed_browse = 1

augroup haskell
  autocmd!
  autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>:SyntasticReset<cr>
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" tagbar
" let g:tagbar_type_haskell = {
"     \ 'ctagsbin'  : 'hasktags',
"     \ 'ctagsargs' : '-x -c -o-',
"     \ 'kinds'     : [
"         \  'm:modules:0:1',
"         \  'd:data: 0:1',
"         \  'd_gadt: data gadt:0:1',
"         \  't:type names:0:1',
"         \  'nt:new types:0:1',
"         \  'c:classes:0:1',
"         \  'cons:constructors:1:1',
"         \  'c_gadt:constructor gadt:1:1',
"         \  'c_a:constructor accessors:1:1',
"         \  'ft:function types:1:1',
"         \  'fi:function implementations:0:1',
"         \  'o:others:0:1'
"     \ ],
"     \ 'sro'        : '.',
"     \ 'kind2scope' : {
"         \ 'm' : 'module',
"         \ 'c' : 'class',
"         \ 'd' : 'data',
"         \ 't' : 'type'
"     \ },
"     \ 'scope2kind' : {
"         \ 'module' : 'm',
"         \ 'class'  : 'c',
"         \ 'data'   : 'd',
"         \ 'type'   : 't'
"     \ }
" \ }
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
"
" " Type of expression under cursor
" nmap <silent> <leader>ht :GhcModType<CR>
" " Insert type of expression under cursor
" nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" " GHC errors and warnings
" "nmap <silent> <leader>hc :SyntasticCheck hdevtools<CR>
" nmap <silent> <leader>hc :GhcModCheck<CR>
" " Haskell Lint
" nmap <silent> <leader>hl :SyntasticCheck hlint<CR>
" " Hoogle the word under the cursor
" nnoremap <silent> <leader>hh :Hoogle<CR>
" " Hoogle and prompt for input
" nnoremap <leader>hH :Hoogle 
" " Hoogle for detailed documentation (e.g. "Functor")
" nnoremap <silent> <leader>hi :HoogleInfo<CR>
" " Hoogle for detailed documentation and prompt for input
" nnoremap <leader>hI :HoogleInfo 
" " Hoogle, close the Hoogle window
" nnoremap <silent> <leader>hz :HoogleClose<CR>
"
" " Haskell conversions
" function! Pointfree()
"   call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
" endfunction
" vnoremap <silent> <leader>h. :call Pointfree()<CR>
"
" function! Pointful()
"   call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
" endfunction
" vnoremap <silent> <leader>h> :call Pointful()<CR>
