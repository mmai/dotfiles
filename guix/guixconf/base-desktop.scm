(map specification->package 
  (append
    (include "./base-terminal.scm")
    '("alacritty" "meld" "python-tmuxp" "firefox"
      "gnome-shell-extension-dash-to-panel"
      )
  ))
