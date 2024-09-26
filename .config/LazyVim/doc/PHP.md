# PHP

NeoVim > LazyVim > Mason / LSP 

Trouble




## Fonctionnalités

- debogueur
  - TODO ? : limiter nombre de xdebug
- lint via phpcs
  - TODO : spécification des règles utilisées
- refactoring
  - code actions via none-ls > phpcs-fixer ; phpcs
- formatage conform.nvim > phpcs-fixer
- symboles references navigation
- complétion
- génération auto
  - phpdoc

### refs

- https://www.lazyvim.org/extras/lang/php
- https://github.com/squizlabs/PHP_CodeSniffer/wiki/Advanced-Usage
- https://gist.github.com/JBlond/d44883595667e185ee45af4eda29570e / https://raw.githubusercontent.com/squizlabs/PHP_CodeSniffer/master/phpcs.xml.dist

## todo ?

- phpstan / phpmd / phpcbf available in mason
- configuration règles phpcs avec phpcs.xml (cf. https://raw.githubusercontent.com/squizlabs/PHP_CodeSniffer/master/phpcs.xml.dist)
- choix de lsp dans config/options.lua : actuellement phpactor par défaut
  - tester intelephense ?
- config noice pour ne plus afficher en popup ? ou filtrer selon types messages ? https://github.com/folke/noice.nvim

## History

------------ d04a538f *lazyvim refact* -------------------

OK
- debogueur

Problèmes
- possibilité garder liste treesitter ouvert dans une fenetre latérale ?
- reference avec gr : n'ouvre pas Treesitter

        Info  15:10:22 lsp.message LSP Message (phpactor) ... scanned 0 references confirmed 2 ...
        Info  15:10:22 lsp.message LSP Message (phpactor) Found 7 reference(s)
        Info  15:10:22 notify.info telescope.nvim [telescope.builtin.lsp_references]: No LSP References found

- references avec space-j (trouble + ): se rafraîchissent au changement de buffer -> on ne peut pas garder la liste des références initiales pour naviger dans tous les fichiers.

config/lazy.lua & lazyvim.json
  LazyVim extra

    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.php" },
    { import = "lazyvim.plugins.extras.test.core" },

    { import = "lazyvim.plugins.extras.dap.core" },

config/keymaps.lua

    -- references
    keymap("n", "<leader>j", "<Cmd>Trouble lsp toggle<CR>", { silent = true, desc = "LSP definitions, references, ..." })

plugins/overrides.lua

    {
      "jay-babu/mason-nvim-dap.nvim",
      config = function()
        local dap = require("dap")
        local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin"

        dap.adapters = {
          php = {
            type = "executable",
            command = mason_bin_path .. "/php-debug-adapter",
          },
        }

        dap.configurations = {
          php = {
            {
              type = "php",
              request = "launch",
              name = "[ Listen for Xdebug ]",
              port = 9003,
            },
          },
        }
      }

plugins/additional.lua

    { "gpanders/editorconfig.nvim" }, -- follow formatting options of .editorconfig file
    {
      "Rican7/php-doc-modded", -- phpdoc generation
      keys = {
        { "<leader>ch", "<cmd>call PhpDocSingle()<cr>", desc = "PHPDoc" },
      },
    },

plugins/tests.lua : juste config adapters, la conf neotest de base vient de _extra.test.core_

      { "olimorris/neotest-phpunit" },
      {
        "nvim-neotest/neotest",
        opts = {
          adapters = {
            "neotest-phpunit", -- only works with  with lazyvim.plugins.extras.test.core enabled
          },
        },
      },
