local opts = {
  setup = {
    init_options = {
      -- language_server_psalm = {
      --   enabled = true,
      --   bin = "/home/henri/.config/vendor/vimeo/psalm/psalm",
      -- },
      -- language_server_phpstan = {
      --   enabled = true,
      --   bin = "/home/henri/.config/vendor/bin/phpstan",
      -- },
      ["language_server_psalm.enabled"] = true,
      ["language_server_psalm.bin"] = "/home/henri/.config/vendor/vimeo/psalm/psalm",
      ["language_server_phpstan.enabled"] = true,
      ["language_server_phpstan.bin"] = "/home/henri/.config/vendor/bin/phpstan",
    }
  }
}

return opts
