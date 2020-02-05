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

" Show buffers in tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#excludes = []
" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1 " Exchange tabs
" and buffers positions. Only works
" with ctrlspace plugin...

"----------------- Welcome screen (startify)
function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

" let g:startify_custom_header = s:center(g:ascii)
let g:startify_fortune_use_unicode = 1


let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]


" let g:startify_custom_header = s:center(map(s:startify_ascii_header +
        " \ startify#fortune#quote(), '"   ".v:val'))
let g:startify_custom_header = ''
