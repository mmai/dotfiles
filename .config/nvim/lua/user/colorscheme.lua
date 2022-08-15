vim.cmd [[
try
  colorscheme darkplus
  " my overrides for darkplus
  hi TSTitle cterm=bold guifg=#4FC1FF gui=bold
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

" telekasten ==highlight== 
hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold

]]
