return {
  ------------------------------------------
  -- Disable some plugins
  ------------------------------------------
  { "RRethy/vim-illuminate", enabled = false }, -- automatically highlight other uses of the word under the cursor
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
        }
      }
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
      { "<S-q>", function() require("mini.bufremove").delete(0, false) end }, -- ajout shortcut
    },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      local dap = require("dap")
      local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin"

      dap.adapters.php = {
        type = 'executable',
        command = mason_bin_path .. "/php-debug-adapter",
      }

      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = "Listen for Xdebug",
          port = 9003,
        },
      }
    end,
  },

  ------------------------------------------
  -- Additionnal plugins
  ------------------------------------------
  -- {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}, -- for handling what mason cannot ( rust-analyzer on NixOS )
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        stylua = {
          mason = false,
          cmd = { vim.fn.expand("/run/current-system/sw/bin/stylua") },
        },

        lua_ls = {
          mason = false,
          cmd = { vim.fn.expand("/run/current-system/sw/bin/lua-language-server") },
        },

        rust_analyzer = {
          mason = false,
          cmd = { vim.fn.expand("/run/current-system/sw/bin/rust-analyzer") },
          settings = {
            ["rust-analyzer"] = {
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = { enable = true, },
              },
              procMacro = { enable = true, },
            },
          },
        },

      },
    },
  },
  {
    "numToStr/Navigator.nvim", -- navigate through tmux panes
    lazy = true,
    config = function()
      require("Navigator").setup({
        auto_save = "current",
      })
    end,
    keys = {
      { "<C-h>", "<CMD>NavigatorLeft<CR>" },
      { "<C-l>", "<CMD>NavigatorRight<CR>" },
      { "<C-k>", "<CMD>NavigatorUp<CR>" },
      { "<C-j>", "<CMD>NavigatorDown<CR>" },
    },
  },

  {
    "mmai/vim-markdown-wiki", -- eases the navigation between files in a personnal wiki based on markdown
    lazy = false,
    ft = { "markdown" },
    keys = {
      { ",<CR>", "<C-w>v:MdwiGotoLink<CR>", opts }
    }
  },
  { "gpanders/editorconfig.nvim" }, -- follow formatting options of .editorconfig file
  {
    "tpope/vim-fugitive",           -- for Git blame
    keys = {
      { "<leader>gb", ":Git blame<CR>", desc = "git blame" },
    }
  },

  {
    'Rican7/php-doc-modded', -- phpdoc generation
    keys = {
      { "<leader>ch", "<cmd>call PhpDocSingle()<cr>", desc = "PHPDoc" },
    }
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    keys = {
      { "<leader>gf", ":Telescope advanced_git_search search_log_content_file<CR>", desc = "search in file log content" },
      {
        "<leader>gd",
        ":Telescope advanced_git_search diff_commit_file<CR>",
        desc =
        "diff current file with commit"
      },
      -- { "<leader>gl", ":Telescope advanced_git_search diff_commit_line<CR>", desc = "diff current file with selected line history" }, -- TODO : mode visual
      {
        "<leader>ga",
        ":Telescope advanced_git_search diff_branch_file<CR>",
        desc =
        "diff current file with branch"
      },
      {
        "<leader>gC",
        ":Telescope advanced_git_search changed_on_branch<CR>",
        desc =
        "list of changed files on the current branch"
      },
    },
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup {
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            -- fugitive or diffview
            diff_plugin = "fugitive",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
          }
        }
      }

      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- OPTIONAL: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      -- "sindrets/diffview.nvim",
    },
  },

  {
    "gbprod/yanky.nvim", -- Allow to paste previous yanks
    config = function()
      require("yanky").setup({
        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)"),
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)"),
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)"),
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)"),
        vim.keymap.set("n", "<a-p>", "<Plug>(YankyCycleForward)"),
        vim.keymap.set("n", "<a-o>", "<Plug>(YankyCycleBackward)"),
        vim.keymap.set("n", "<a-h>", ":Telescope yank_history<cr>"),
      })
      require("telescope").load_extension("yank_history")
    end
  },

  -- { "https://gitlab.com/schrieveslaach/sonarlint.nvim", -- code quality ; needs jdk installed, still do nothing
  --   config = function()
  --     require('sonarlint').setup({
  --       server = {
  --           cmd = {
  --             'sonarlint-language-server',
  --             -- Ensure that sonarlint-language-server uses stdio channel
  --             '-stdio',
  --             '-analyzers',
  --             -- paths to the analyzers you need
  --             vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
  --             vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
  --           }
  --       },
  --       filetypes = {
  --           'python',
  --           'php',
  --       }
  --     })
  --   end
  -- },
}
