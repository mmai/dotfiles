"-----------        PHP       ----------

" autocmd FileType php LanguageClientStart " probably not needed ?

" associate .feature files with behat (vim default is cucumber) 
let g:feature_filetype='behat'

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

" automatically sort namespaces after inserting
let g:php_namespace_sort_after_insert=1

" Expand class to its fully qualified name
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
