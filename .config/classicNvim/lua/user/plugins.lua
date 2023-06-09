local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    " autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim"}) -- Have packer manage itself
	use({ "lewis6991/impatient.nvim"}) -- speed up lua modules startup
	use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
	use({ "tpope/vim-repeat"}) -- allow the use of the repeat key `.` for plugins mappings. Used by vim-surround
	use({ "tpope/vim-surround"}) -- cs"' ; ds' ; ysiw] ; yss) ; ysiw<em> ; cstAutopairs, integrates with both cmp and treesitter_ 
	use({ "numToStr/Comment.nvim"})
	-- use({ "JoosepAlviste/nvim-ts-context-commentstring"}) -- switch comment string according to treesitter detected language (usefull for .vue files) XXX : seems to break line comments, they are treated like block comments
	use({ "moll/vim-bbye"}) -- close buffers without destroying windows
  use({ "ton/vim-bufsurf"}) -- enables surfing through buffers based on viewing history per window
  -- use({ "karb94/neoscroll.nvim",  -- smooth scroll
  --   config = function()
  --     require("neoscroll").setup {}
  --   end
  -- })
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }
  use { 'phaazon/hop.nvim', branch = 'v2', -- easy movements
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
	use({ "monaqa/dial.nvim"}) -- Extended increment/decrement ( <ctrl>a , <ctrl>x )
  -- UI
	use({ "goolord/alpha-nvim"}) -- greeter UI
	use({ "kyazdani42/nvim-web-devicons"})
	use({ "kyazdani42/nvim-tree.lua"}) -- file explorer
	use({ "akinsho/bufferline.nvim"}) -- tab bar
	use({ "nvim-lualine/lualine.nvim"}) -- status bar
  use({ "petertriho/nvim-scrollbar", -- scroll bar
    config = function()
      require("scrollbar").setup()
    end
  })
	use({ "folke/which-key.nvim"}) -- menu / show keybindings
	use({ "romainl/vim-cool"}) -- disables search highlighting when you are done searching and re-enables it when you search again
	use({ "nvim-telescope/telescope.nvim"}) -- Telescope (fzf like)
  use("nvim-telescope/telescope-symbols.nvim") -- symbols picker with telescope
  -- use { "nvim-lua/popup"} -- required by telescope-media-files
  use { "nvim-telescope/telescope-media-files.nvim"} -- media files viewer, used by telekasten.vim
  use({ "gbprod/yanky.nvim", -- Allow to paste previous yanks
    config = function()
      require("yanky").setup({
        vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)");
        vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)");
        vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)");
        vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)");

        vim.keymap.set("n", "<a-p>", "<Plug>(YankyCycleForward)");
        vim.keymap.set("n", "<a-o>", "<Plug>(YankyCycleBackward)");
        vim.keymap.set("n", "<a-h>", ":Telescope yank_history<cr>");
      })
      require("telescope").load_extension("yank_history")
    end
  })
 use { "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        plugins = { tmux = true, gitsigns = true },
        window = { options = { number = false, relativenumber = false }}
      }
    end
  }
  use { "folke/twilight.nvim", -- to use in pair with zen mode : dim portions of text
    config = function()
      require("twilight").setup {}
    end
  }
	use({ "akinsho/toggleterm.nvim"})
  use({ "christoomey/vim-tmux-navigator"}) -- Allow pane movement to jump out of vim into tmux

	use({ "lukas-reineke/indent-blankline.nvim"})
	use({ "ahmedkhalf/project.nvim"})
  use({ "gpanders/editorconfig.nvim"}) -- follow formatting options of .editorconfig file

 -- Git
	use({ "tpope/vim-fugitive"})
	use({ "lewis6991/gitsigns.nvim"})

  -- Markdown
  use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  use("mzlogin/vim-markdown-toc") -- generate table of contents for Markdown files
  use("pbrisbin/vim-mkdir") -- Automatically create any non-existent directories before writing the buffer
  use("mmai/vim-markdown-wiki") -- eases the navigation between files in a personnal wiki based on markdown
  use("renerocksai/calendar-vim") -- used by telekasten.vim
  use("renerocksai/telekasten.nvim")
  -- use {
  --   "nvim-neorg/neorg",
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ["core.defaults"]        = {},
  --         ["core.norg.concealer"]  = { config = {
  --           icons = {
  --             todo = {
  --               undone = {
  --                 icon = " ", -- instead of "×"
  --               }
  --             },
  --           },
  --         }},
  --         ["core.keybinds"]        = { config = { neorg_leader = "<space>o" } }, -- defaults = <LocalLeader>
  --         ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
  --         ["core.norg.journal"]    = { config = { workspace = "home" } },
  --         -- ["core.gtd.base"]        = { config = { workspace = "gtd" }},
  --         ["core.norg.dirman"]     = { config = {
  --           workspaces = {
  --             home = "~/think",
  --             gtd = "~/think/gtd",
  --             atixnet = "~/think/atixnet",
  --           }
  --         }},
  --       }
  --     }
  --   end,
  --   requires = "nvim-lua/plenary.nvim"
  -- }
  -- Text utils
  use("salsifis/vim-transpose") -- transpose lines to columns (:Transpose)
  use("godlygeek/tabular") -- :Tabularize /|

	-- Colorschemes
	use({ "folke/tokyonight.nvim"})
	-- use({ "lunarvim/darkplus.nvim", branch = 'neovim-0.7'})
	use({ "lunarvim/darkplus.nvim"})
	use "rebelot/kanagawa.nvim"
  use 'folke/lsp-colors.nvim' -- Automatically creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin lsp client.

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer"}) -- buffer completions
	use({ "hrsh7th/cmp-path"}) -- path completions
	use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" }) -- function signature completion
	use({ "hrsh7th/cmp-nvim-lsp"})
	use({ "hrsh7th/cmp-nvim-lua"})

	-- snippets
	use({ "L3MON4D3/LuaSnip"}) --snippet engine
	use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

	use({ "nvim-treesitter/nvim-treesitter"}) -- Treesitter
	use({ "nvim-treesitter/playground"}) -- view treesitter information (provides :TSCaptureUnderCursor to show syntax group, then do `:verbose highlight <syntax group>` to debug coloring issues)

  use { 'stevearc/aerial.nvim', config = function() require('aerial').setup() end } -- code outline sidebar

  -- languages support
  use { 'LnL7/vim-nix' }

  -- PHP
    -- phpdoc generation
  use { 'Rican7/php-doc-modded' }

	-- IDE
  use { "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  }
  use { "williamboman/mason.nvim", branch = 'main' } -- exernal tools installer (lsp & dap servers among others)
    -- LSP
  use { "williamboman/mason-lspconfig.nvim" }
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
	use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
    -- DAP debugger
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }
    -- Tests runner
  use { "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'rouge8/neotest-rust',
      'olimorris/neotest-phpunit',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-phpunit'),
          require("neotest-rust"),
        }
      })
    end
  }
  -- Trouble
  use { "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  -- REPL
  use 'Olical/conjure' -- essentially for lisp languages (and rust)
  vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket" -- use Guile for scheme scripts

  -- Misc tools
  use 'Olical/nvim-local-fennel' -- execute local project (.git) fennel code in `.lnvim.fnl` file at startup
  use 'Olical/aniseed' -- useful fennel library
  use { "HiPhish/awk-ward.nvim" } -- Awk repl by running :AwkWard on a buffer with an Awk expressions

  -- Fun
  use 'eandrju/cellular-automaton.nvim'

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
