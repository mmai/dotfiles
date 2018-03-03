# Readme

## Notes on installation

*FZF plugin* also installs the zsh command : CTRL-R for history, CTRL-T for files, ALT-C to cd in directories, or completion with : COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB>
The `--all` option in _vimrc_ installs fzf outside of vim (ie for zsh) as well, use `--bin` for a vim only version

*Vdebug* needs python2 `pip2 install neovim`

*lvht/phpcd* (php completing) : see github page for php requirements

## Commands and shortcuts

### File navigation

_Global search_ `:Ag <search string>`
_Jump from current file to its directory_ `-` 

### Windows

_Swap windows_ `<leader>ww` (1st time on 1st window, 2nd time on 2nd window)

### Text manipulation

_Search and replace in multiple files_ `:Far foo bar **/*.py` `:Fardo`
_Change surroundings_ `cs'<p>` inside `'toto'` transforms to `<p>toto</p>`, `cst'` to revert
_Edit only selected region_ Select region, then `:NR`
_Navigate history of yanks backwards_ `<ALT-p>`
_Navigate history of yanks forwards_ `<ALT-SHIFT-p>`
_Navigate history of undos_ `,u`
_Align elemnts_ `:Tabularize /<delimiter string>`
_Multiple cursors : select current word, then the next..._ `<C-n>` 
_Multiple cursors : cancel selection_ `<C-p>`  
_Multiple cursors : omit current selection_ `<C-x>` 
_Multiple cursors : go to normal mode and edit_ `v` 
_Multiple cursors : back to regular Vim_ `<ESC>`

_Emmet : expand CSS selectors expression to HTML_ (ie div#page>div.logo+ul#navigation>li*5>a). On insert mode:
* _Complete abbreviation_ `<C-y>,`(don't forget the ',')
* _Go to next/previous edit point_ `<C-y>n` / `<C-y>N` 
* _Select element_ `<C-y>d`

### Snippets

_Current date time_ `,dt`

### IDE related

_Toggle indentation colorizing_ `,ig`
_Toggle tagbar_ `,tt`
_Toggle syntastic_ `,ide`

Git:
* _Open commit browser_ `:GV`
* _Open commit browser for current file_ `:GV!`
* _Fills the location list with the revisions of the current file_ `:GV?`

`:GV` or `:GV?` can be used in visual mode to track the changes in the selected lines.

Debugger:

* _Add break point_ `<F10>`
* _Start listening_ `<F5>`

PHP completion (phpcd)
* _PHP completion : jump to function definition_ <C-]> 
* _PHP completion : jump back_ <C-t>

Haskell
