if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
setlocal formatprg=hindent " is superceded by formatexpr
setlocal keywordprg=":stack hoogle"
setlocal omnifunc=necoghc#omnifunc

noremap <buffer> <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>:SyntasticReset<cr>

" Hoogle the word under the cursor
nnoremap <buffer> <silent> <leader>hh :Hoogle<CR>
" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <buffer> <silent> <leader>hd :HoogleInfo<CR>
" Hoogle, close the Hoogle window
nnoremap <buffer> <silent> <leader>hz :HoogleClose<CR>

" --- Intero
nnoremap <buffer> <silent> <leader>io :InteroOpen<CR>
nnoremap <buffer> <silent> <leader>iov :InteroOpen<CR><C-W>H
nnoremap <buffer> <silent> <leader>ih :InteroHide<CR>
nnoremap <buffer> <silent> <leader>is :InteroStart<CR>
nnoremap <buffer> <silent> <leader>ik :InteroKill<CR>
nnoremap <buffer> <silent> <leader>wr :w \| :InteroReload<CR>
nnoremap <buffer> <silent> <leader>il :InteroLoadCurrentModule<CR>
nnoremap <buffer> <silent> <leader>if :InteroLoadCurrentFile<CR>
noremap  <buffer> <leader>t <Plug>InteroGenericType
noremap  <buffer> <leader>T <Plug>InteroType
nnoremap <buffer> <silent> <leader>it :InteroTypeInsert<CR>
nnoremap <buffer> <silent> <leader>d :InteroGoToDef<CR>
nnoremap <buffer> <silent> <leader>iu :InteroUses<CR>
nnoremap <buffer> <leader>ist :InteroSetTargets<SPACE>
