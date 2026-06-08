return {
  ------------------------------------------
  -- Additional plugins
  ------------------------------------------
  -- flutter-tools : uses lsp for flutter and dart applications
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim", -- optional for vim.ui.select
  --   },
  --   config = true,
  -- },
  -- { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" }, -- for handling what mason cannot ( rust-analyzer on NixOS )
  -- { "danymat/neogen", config = true }, -- Code documentation generator (moins complet que vim-doge : pas d'indication des types en PHP)
  {
    "kkoomen/vim-doge", -- Code documentation generator ; nécessite l'exécution  de `:call doge#install()` pour finaliser l'installation
  },
  -- {
  --   "Rican7/php-doc-modded", -- phpdoc generation
  --   keys = {
  --     { "<leader>ch", "<cmd>call PhpDocSingle()<cr>", desc = "PHPDoc" },
  --   },
  -- },
  {
    "likec4/likec4.nvim",
    build = "npm install @likec4/lsp",
  },
  { "chrisbra/Recover.vim" }, -- add 'Compare' option when vim find a swap file
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  { "wakatime/vim-wakatime", lazy = false },
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
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "tpope/vim-fugitive", -- for Git blame
    keys = {
      { "<leader>gb", ":Git blame<CR>", desc = "git blame" },
    },
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    keys = {
      {
        "<leader>gf",
        ":Telescope advanced_git_search search_log_content_file<CR>",
        desc = "search in file log content",
      },
      {
        "<leader>gd",
        ":Telescope advanced_git_search diff_commit_file<CR>",
        desc = "diff current file with commit",
      },
      -- { "<leader>gl", ":Telescope advanced_git_search diff_commit_line<CR>", desc = "diff current file with selected line history" }, -- TODO : mode visual
      {
        "<leader>ga",
        ":Telescope advanced_git_search diff_branch_file<CR>",
        desc = "diff current file with branch",
      },
      {
        "<leader>gC",
        ":Telescope advanced_git_search changed_on_branch<CR>",
        desc = "list of changed files on the current branch",
      },
    },
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup({
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
          },
        },
      })

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
    end,
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

  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     -- for example
  --     provider = "claude",
  --     providers = {
  --       claude = {
  --         -- auth_type = "max",
  --         -- endpoint = "https://api.anthropic.com",
  --         model = "claude-sonnet-4-20250514",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 20480,
  --         },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-mini/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
