"  Javascript

let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
let g:LanguageClient_serverCommands["javascript.jsx"] = ['javascript-typescript-stdio']
let g:LanguageClient_serverCommands["vue"] = ['vls']
" Install _vls_ whith : npm install vue-language-server --save

let g:ale_fixers.javascript = ['eslint']
let g:ale_fixers.vue = ['prettier']
