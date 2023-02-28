# Nushell settings for nnn

# NNN PLUGINS
#   list of plugins at https://github.com/jarun/nnn/tree/master/plugins#list-of-plugins
#	  install all with `curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh`
# shortcuts for executing plugins ( ie `;f` will launch finder, etc.)
# ( or simply press `;<enter>` to select a plugin)
let-env NNN_PLUG = 'f:fzcd;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview'

# The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
let cfgHome = ($env | default $env.HOME XDG_CONFIG_HOME | get XDG_CONFIG_HOME)
let-env NNN_TMPFILE = $"($cfgHome)/.config/nnn/.lastd"

def-env nn [...x] {
  # Launch nnn. Add desired flags after `^nnn`, ex: `^nnn -eda ($x | str join)`
  ^nnn -eda ($x | str join)
  let newpath = (
    if ($env.NNN_TMPFILE | path exists) {
      let newpath = (open $env.NNN_TMPFILE | parse 'cd "{nnpath}"').0.nnpath
      ^rm -f $env.NNN_TMPFILE
      echo $newpath
    } else {
      pwd
    }
  )
  cd $newpath
}

