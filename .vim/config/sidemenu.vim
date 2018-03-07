let g:ttt = "hoho"
let g:sidemenu = [
	\   { 'title': 'General & Plugins',
	\     'children': [
	\       ['ga', 'call dein#update()', 'Plugins update', 'Update all plugins'],
	\       ['gb', 'Denite dein -no-quit', 'Plugins list'],
	\       ['gc', 'Denite session', 'Restore session'],
	\       ['gc', 'Denite session/new', 'Save session…'],
	\       ['gd', 'Denite z', 'Z (jump around)'],
	\       ['ge', 'Denite help', 'Vim help'],
	\       ['gf', 'Denite command command_history', 'Command history'],
	\   ]},
	\   { 'title': 'Project',
	\     'children': [
	\       ['po', 'TagbarToggle', 'Tag Outline'],
	\       ['ps', 'Denite gitstatus', 'Git status'],
	\       ['pb', 'call feedkeys("ma")', 'Bookmarks'],
	\       ['pu', 'UndotreeToggle', 'Undo tree'],
	\   ]},
	\   { 'title': 'Files',
	\     'children': [
	\       ['fe', 'NERDTreeToggle', 'File explorer'],
	\       ['fg', 'Ag', 'Find in files…'],
	\       ['ff', 'Files', 'Find files'],
	\       ['fr', 'Far', 'Find and replace'],
	\       ['fb', 'Buffers', 'Buffers'],
	\   ]},
	\   { 'title': 'Tools',
	\     'children': [
	\       ['a', 'Denite gitlog:all', 'Git log'],
	\       ['b', 'Denite gitstatus', 'Git status'],
	\       ['c', 'Denite gitchanged:', 'Git changed'],
	\       ['d', 'Neomake', 'Check syntax'],
	\       ['e', 'Denite register -buffer-name=register -default-action=replace', 'Paste from…'],
	\       ['f', 'Goyo', 'Goyo'],
	\       ['g', 'Thesaurus', 'Thesaurus'],
	\       ['h', 'XtermColorTable', 'Xterm color-table'],
	\       ['i', 'Vinarise', 'Hex editor'],
	\       ['j', 'Codi python', 'Codi (python)'],
	\   ]},
	\   { 'title': 'System',
	\     'children': [
	\       ['1', 'CheckHealth', 'Check health'],
	\       ['2', 'echo dein#get_updates_log()', 'View updates log'],
	\       ['3', 'echo dein#get_log()', 'View dein log'],
	\   ]},
	\ ]

