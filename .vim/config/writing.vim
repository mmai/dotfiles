" WRITING

" default spelling languages
set spelllang=fr,en_us

let g:languagetool_jar= '/usr/local/LanguageTool/LanguageTool.jar'

" enable toggle checkbox on markdown files (enabled by default in vim-mardown but was disabled by polyglot plugin)
let g:markdown_enable_mappings = 1

" Distraction free writing
  " Starts Goyo with Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
