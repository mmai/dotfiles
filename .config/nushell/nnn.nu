# Nushell settings for nnn

# NNN PLUGINS
#   list of plugins at https://github.com/jarun/nnn/tree/master/plugins#list-of-plugins
#	  install all with `curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh`
# shortcuts for executing plugins ( ie `;f` will launch finder, etc.)
# ( or simply press `;<enter>` to select a plugin)
$env.NNN_PLUG = 'f:fzcd;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview'

# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
# let cfgHome = ($env | default $"($env.HOME)/.config" XDG_CONFIG_HOME | get XDG_CONFIG_HOME)
# $env.NNN_TMPFILE = $"($cfgHome)/nnn/.lastd"
#
# def-env nn [...x] {
#   # Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
#   ^nnn -eda ($x | str join)
#
#   # echo $env.NNN_TMPFILE # debug
#   # open $env.NNN_TMPFILE  # debug
#   let newpath = (
#     if ($env.NNN_TMPFILE | path exists) {
#       let newpath = (open $env.NNN_TMPFILE | parse 'cd "{nnpath}"').0.nnpath
#       ^rm -f $env.NNN_TMPFILE
#       echo $newpath
#     } else {
#       pwd
#     }
#   )
#   cd $newpath
# }
#
# export def --env n [
#   ...flags : string # Extra flags to launch nnn with.
# ] -> nothing {
#
# 	# let config_home = if ($env.XDG_CONFIG_HOME | is-empty) {
# 	# 	$'($env.HOME)/.config/'
# 	# } else {
# 	# 	$env.XDG_CONFIG_HOME
# 	# }
#  let config_home = ($env | default $"($env.HOME)/.config" XDG_CONFIG_HOME | get XDG_CONFIG_HOME)
#
# 	# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set).
# 	let nnn_tmpfile = $config_home + '/nnn/.lastd'
#
# 	# Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
# 	NNN_TMPFILE=$nnn_tmpfile ^nnn ...$flags
#
# 	if ($nnn_tmpfile | path exists) {
# 		# Remove <cd '> from the first part of the string and the last single quote <'>.
# 		# Fix post-processing of nnn with path, escaping single quotes with POSIX syntax.
# 		let path = (open $nnn_tmpfile | str substring 4..-1 | str replace --all `'\''` `'`)
#
# 		^rm -f $nnn_tmpfile
#
# 		cd $path
# 	}
# }
