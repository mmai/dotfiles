"------------------------  Status bar (vim-airline)

let g:airline_powerline_fonts = 1
let g:airline_left_sep='' " default : >
let g:airline_right_sep='' " default : <
" let g:airline_theme='one'

" Show file encoding in the status line
if has("statusline")
 "git branch in status line
 set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif
