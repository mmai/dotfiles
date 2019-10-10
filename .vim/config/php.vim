"-----------        PHP       ----------
"  see also ftplugin/php.vim

let g:php_manual_online_search_shortcut = '<leader>?' " from alvan/vim-php-manual 

" associate .feature files with behat (vim default is cucumber) 
let g:feature_filetype='behat'

" phpcd with neosnippet
let g:phpcd_disable_modifier=0 

" Exlude variables from the tag bar 
" let g:tagbar_type_php  = {
"     \ 'ctagstype' : 'php',
"     \ 'kinds'     : [
"         \ 'i:interfaces',
"         \ 'c:classes',
"         \ 'd:constant definitions',
"         \ 'f:functions',
"         \ 't:traits',
"         \ 'j:javascript functions:1'
"     \ ]
" \ }

" ----- Linter / Fixer w0rp/ale -----
"  install phpcs (phpCodeSniffer) & drupal standards with :
"     composer global require drupal/coder 
"     composer global require dealerdirect/phpcodesniffer-composer-installer
let g:ale_fixers.php = ['phpcbf']
" let g:ale_linters.php = [] " Disable linting, comment to re-enable (if phpcs is installed)
" list available standards with `phpcs -i`
" let g:ale_php_phpcs_standard = 'Drupal' " (work sometimes...) if not set => PEAR Standard
let g:ale_php_phpcs_standard = 'PSR1' " if not set => PEAR Standard
" let g:ale_php_phpcs_options = '--show_warnings 0'

"     cf. https://github.com/dense-analysis/ale/issues/2427
" If I don't do this, phpcbf fails on any file in the exclude-pattern :/
let g:ale_php_phpcbf_executable = $HOME.'/.vim/support/phpcbf-helper.sh'
" in order to get the alternate executable working you have to declare it as
" use global, even though it's not 'global' :/
let g:ale_php_phpcbf_use_global = 1

" -------- vim-php-namespace plugin
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

" ------------ adoy/vim-php-refactoring-toolbox plugin
let g:vim_php_refactoring_use_default_mapping = 0 " see new mappings in ftplugin/php.vim
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

" ----------- Testing (vim-test plugin)
let test#php#phpunit#options = { 'file': '--testdox' }
" let test#php#phpunit#options = '--testdox'
let test#php#phpspec#options = '--format=pretty'
