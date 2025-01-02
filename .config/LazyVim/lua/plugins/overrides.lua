return {
  ------------------------------------------
  -- Disable some plugins
  ------------------------------------------
  -- remove disturbing current words highlighting
  { "RRethy/vim-illuminate", enabled = false }, -- automatically highlight other uses of the word under the cursor
  { "snacks.nvim", opts = { words = { enabled = false } } }, -- Auto-show LSP references and quickly navigate between them
  ------------------------------------------
  --  colorscheme
  ------------------------------------------
  { "lunarvim/darkplus.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darkplus",
    },
  },

  ------------------------------------------
  -- LazyVim enabled - conf overrides
  ------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      -- Add an underline below treesitter context header
      vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
      vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
    end,
  },
  {
    "folke/flash.nvim",
    keys = {
      -- disable the default flash keymap
      { "s", mode = { "n", "x", "o" }, false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim", -- file explorer
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<S-q>",
        function()
          require("mini.bufremove").delete(0, false)
        end,
      }, -- ajout shortcut
    },
  },

  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        cmd = { vim.fn.expand("/run/current-system/sw/bin/rust-analyzer") },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.config/.markdownlint-cli2.yaml"), "--" },
        },
      },
    },
  },

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

        -- pour rust
        codelldb = {
          type = "executable",
          command = "/run/current-system/sw/bin/lldb-vscode",
          name = "codelldb",
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

        rust = {
          {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
          },
          {
            name = "trictrac client CLI",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.getcwd() .. "/target/debug/client_cli"
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            runInTerminal = true,
          },
        },
      }
    end,
  },

  -- remove stylua from mason autoinstall
  -- On NixOS stylua is in "/run/current-system/sw/bin/stylua"
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shfmt", -- remove stylua
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      document_highlight = { enabled = false }, -- disable 'illuminate' other occurence of word on cursor
      servers = {
        lua_ls = {
          mason = false,
          cmd = { vim.fn.expand("/run/current-system/sw/bin/lua-language-server") },
        },
        marksman = {
          mason = false,
          cmd = { vim.fn.expand("/run/current-system/sw/bin/marksman") },
        },

        -- XXX : désactivé car doublonne avec le rust-analyzer déjà lançé par "mrcjkb/rustaceanvim"
        -- (provoquant un bug inlay type hints duplicated https://www.reddit.com/r/neovim/comments/1axlen1/inlay_hints_invalid_col_out_of_range/)
        --
        -- rust_analyzer = {
        --   mason = false,
        --   cmd = { vim.fn.expand("/run/current-system/sw/bin/rust-analyzer") },
        --   settings = {
        --     ["rust-analyzer"] = {
        --       imports = {
        --         granularity = {
        --           group = "module",
        --         },
        --         prefix = "self",
        --       },
        --       cargo = {
        --         buildScripts = { enable = true },
        --       },
        --       procMacro = { enable = true },
        --     },
        --   },
        -- },
      },
    },
  },
}
