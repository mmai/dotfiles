"-----------        PHP       ----------

" phpcd with neosnippet
let g:phpcd_disable_modifier=0 

" Exlude variables from the tag bar 
let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions',
        \ 'f:functions',
        \ 't:traits',
        \ 'j:javascript functions:1'
    \ ]
\ }

" -------- arnaud-lb/vim-php-namespace plugin
" Automatically insert use statements 
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>pnu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pnu :call PhpInsertUse()<CR>

" automatically sort namespaces after inserting
let g:php_namespace_sort_after_insert=1

" Expand class to its fully qualified name
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>pne <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pne :call PhpExpandClass()<CR>
 
silent! nnoremap <silent> <unique> <buffer> <leader>pd 
			\ :<C-u>call phpcd#JumpToDefinition('normal')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pds
			\ :<C-u>call phpcd#JumpToDefinition('split')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pdv
			\ :<C-u>call phpcd#JumpToDefinition('vsplit')<CR>
" does not work ???
silent! nnoremap <silent> <unique> <buffer> <leader>pb
\ :<C-u>call phpcd#JumpBack()<CR>
