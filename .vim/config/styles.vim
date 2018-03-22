"--------------------------- Styles 

set background=dark
"colorscheme solarized
colorscheme desert

set guifont=DejaVuSansMono\ Nerd\ Font\ 10 

" Set monaco font if using macvim
if has("gui_macvim")
  set guifont=Monaco:h13
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
try
  colorscheme wombat256mod
  " colorscheme one
catch
endtry

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Colorize current line number
" set cursorline
" hi LineNr ctermbg=NONE
" hi CursorLine ctermbg=NONE

" Adjust signscolumn and syntastic to match wombat
hi! link SignColumn LineNr
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign WarningMsg

" indent guides colors (colorize indentations)
let g:indent_guides_auto_colors = 0
augroup indent_guides
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
augroup END

"   Use pleasant but very visible search hilighting 
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search
let g:incsearch#auto_nohlsearch = 1

" Searing red very visible cursor
hi Cursor guibg=red

" Use same color behind concealed unicode characters
hi clear Conceal

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256
