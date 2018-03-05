" FZF Fuzzy-find plugin shortcuts
"  see also the jump to tag alias in coding.vim 

let $FZF_DEFAULT_COMMAND = 'fd --type f'
let $FZF_CTRL_T_COMMAND  = 'fd --type f'
let g:fzf_layout = { 'down': '~40%' }

map <C-p> :Files<cr>
nmap <C-p> :Files<cr>
 
" View commits in fzf
nmap <Leader>c :Commits<cr>

" Complete from open tmux panes (from @junegunn)
inoremap <expr> <C-x><C-t> fzf#complete( 'tmuxwords.rb -all-but-current --scroll 499 --min 5')
inoremap <expr> <C-x><C-k> fzf#complete ('cat /usr/share/dict/words')

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

