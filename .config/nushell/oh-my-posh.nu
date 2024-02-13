let poshThemesDir = (readlink -f (^which oh-my-posh)| str replace "bin/oh-my-posh" "share/oh-my-posh/themes/")
# let poshTheme = $"($poshThemesDir)powerlevel10k_rainbow.omp.json" 
# let poshTheme = $"($poshThemesDir)slim.omp.json" 
# let poshTheme = $"($poshThemesDir)tiwahu.omp.json" 
# let poshTheme = $"($poshThemesDir)peru.omp.json" 
let poshTheme = $"($env.HOME)/.config/rhumbs.omp.json" # my custom config based on peru.omp.json

# ---- oh-my-posh initialization
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_NORMAL = "" 
$env.PROMPT_INDICATOR_VI_INSERT = ""
# By default displays the right prompt on the first line
# making it annoying when you have a multiline prompt
# making the behavior different compared to other shells
$env.PROMPT_COMMAND_RIGHT = "" 
$env.NU_VERSION = (version | get version)

$env.PROMPT_MULTILINE_INDICATOR = (oh-my-posh print secondary $"--config=($poshTheme)" --shell=nu $"--shell-version=($env.NU_VERSION)")
$env.PROMPT_COMMAND = { ||
  # We have to do this because the initial value of `$env.CMD_DURATION_MS` is always `0823`,
  # which is an official setting.
  # See https://github.com/nushell/nushell/discussions/6402#discussioncomment-3466687.
  let cmd_duration = if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS }

  let width = ((term size).columns | into string)
  oh-my-posh prompt print primary --config $"($poshTheme)" --shell=nu $"--shell-version=($env.NU_VERSION)" $"--execution-time=($cmd_duration)" $"--error=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)" 
}
