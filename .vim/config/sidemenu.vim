let g:sidemenu = [
	\   { 'title': 'General & Plugins',
	\     'children': [
	\       ['ve', 'vsplit $HOME/.vim/vimrc', 'Edit vim config'],
	\       ['vp', 'PlugInstall', 'Install new plugins'],
	\       ['vp', 'PlugUpgrade', 'Upgrade Plug'],
	\       ['va', 'PlugUpdate', 'Update all plugins'],
	\       ['vc', 'PlugClean', 'Remove old plugins'],
	\       ['vs', 'PlugSnapshot', 'Save current plugin configuration'],
	\   ]},
	\   { 'title': 'Project',
	\     'children': [
	\       ['po', 'TagbarToggle', 'Tag Outline'],
	\       ['ps', 'Denite gitstatus', '*Git status'],
	\       ['pb', 'call feedkeys("ma")', 'Bookmarks'],
	\       ['pu', 'UndotreeToggle', 'Undo tree'],
	\   ]},
	\   { 'title': 'Files',
	\     'children': [
	\       ['fe', 'NERDTreeToggle', 'File explorer'],
	\       ['ff', 'Files', 'Find files'],
	\       ['fg', 'Ag', 'Find in files…'],
	\       ['fa', 'call feedkeys(",fa")', 'Find word under cursor in files'],
	\       ['fr', 'call feedkeys(",fr")', 'Find and replace'],
	\       ['fs', 'w !sudo tee % >/dev/null', 'Save with sudo'],
	\       ['fb', 'Buffers', 'Buffers'],
	\   ]},
	\   { 'title': 'Tools',
	\     'children': [
	\       ['tf', 'Goyo', 'Distraction free writing'],
	\       ['tp', 'LivedownToggle', 'Preview markdown'],
	\       ['ts', ':setlocal spell! spelllang=fr,en_us', 'Toggle spelling'],
	\       ['a', 'Denite gitlog:all', '*Git log'],
	\       ['b', 'Denite gitstatus', '*Git status'],
	\       ['c', 'Denite gitchanged:', '*Git changed'],
	\       ['d', 'Neomake', '*Check syntax'],
	\       ['e', 'Denite register -buffer-name=register -default-action=replace', '*Paste from…'],
	\       ['g', 'Thesaurus', '*Thesaurus'],
	\       ['h', 'XtermColorTable', '*Xterm color-table'],
	\       ['i', 'Vinarise', '*Hex editor'],
	\       ['j', 'Codi python', '*Codi (python)'],
	\   ]},
	\   { 'title': 'System',
	\     'children': [
	\       ['1', 'CheckHealth', 'Check health'],
	\       ['2', 'echo dein#get_updates_log()', '*View updates log'],
	\       ['3', 'echo dein#get_log()', '*View dein log'],
	\   ]},
	\ ]

