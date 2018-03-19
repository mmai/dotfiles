if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Tabulation
setlocal ts=4 sts=4 sw=4

" namespaces mappings
inoremap <unique> <buffer> <Leader>pnu <Esc>:call IPhpInsertUse()<CR>
noremap  <unique> <buffer> <Leader>pnu :call PhpInsertUse()<CR>
inoremap <unique> <buffer> <Leader>pne <Esc>:call IPhpExpandClass()<CR>
noremap  <unique> <buffer> <Leader>pne :call PhpExpandClass()<CR>
 
" phpcd shortcuts
silent! nnoremap <silent> <unique> <buffer> <leader>pdr :<C-u>call phpcd#JumpToDefinition('normal')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pd  :<C-u>call phpcd#JumpToDefinition('split')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pdv :<C-u>call phpcd#JumpToDefinition('vsplit')<CR>
silent! nnoremap <silent> <unique> <buffer> <leader>pb :call phpcd#JumpBack()<CR>

" refactoring shortcuts
nnoremap <buffer> <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <buffer> <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <buffer> <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <buffer> <leader>reu :call PhpExtractUse()<CR>
vnoremap <buffer> <leader>rec :call PhpExtractConst()<CR>
nnoremap <buffer> <leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <buffer> <leader>rem :call PhpExtractMethod()<CR>
nnoremap <buffer> <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <buffer> <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <buffer> <leader>r== :call PhpAlignAssigns()<CR>
nnoremap <buffer> <leader>rsg :call PhpCreateSettersAndGetters()<CR>

" Rican7/php-doc-modded shortcut
nnoremap <buffer> <leader>h :call PhpDocSingle()<CR>
