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
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
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
	use({ "numToStr/Comment.nvim"})
	use({ "JoosepAlviste/nvim-ts-context-commentstring"}) -- switch comment string according to treesitter detected language (usefull for .vue files)
	use({ "moll/vim-bbye"}) -- close buffers without destroying windows
  use({ "ton/vim-bufsurf"}) -- enables surfing through buffers based on viewing history per window
  use({ "maxbrunsfeld/vim-yankstack"}) -- Allow to paste previous yanks : <alt>p / <alt><shift>p
  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- UI
	use({ "goolord/alpha-nvim"}) -- greeter UI
	use({ "kyazdani42/nvim-web-devicons"})
	use({ "kyazdani42/nvim-tree.lua"}) -- file explorer
	use({ "akinsho/bufferline.nvim"}) -- tab bar
	use({ "nvim-lualine/lualine.nvim"}) -- status bar
	use({ "folke/which-key.nvim"}) -- menu / show keybindings
	use({ "nvim-telescope/telescope.nvim"}) -- Telescope (fzf like)
  use("nvim-telescope/telescope-symbols.nvim") -- symbols picker with telescope
  -- use { "nvim-lua/popup"} -- required by telescope-media-files
  use { "nvim-telescope/telescope-media-files.nvim"} -- media files viewer, used by telekasten.vim

	use({ "akinsho/toggleterm.nvim"})
  use({ "christoomey/vim-tmux-navigator"}) -- Allow pane movement to jump out of vim into tmux

	use({ "lukas-reineke/indent-blankline.nvim"})
	use({ "ahmedkhalf/project.nvim"})
  use({ "gpanders/editorconfig.nvim"}) -- follow formatting options of .editorconfig file

 -- Git
	use({ "tpope/vim-fugitive"})
	use({ "lewis6991/gitsigns.nvim"})

  -- Markdown
  use("iamcco/markdown-preview.nvim")
  use("mzlogin/vim-markdown-toc") -- generate table of contents for Markdown files
  -- use("pbrisbin/vim-mkdir") -- Automatically create any non-existent directories before writing the buffer
  -- use("mmai/vim-markdown-wiki") -- eases the navigation between files in a personnal wiki based on markdown
  use({'jakewvincent/mkdnflow.nvim', -- XXX conflit avec impatient.nvim
    rocks = 'luautf8',
    config = function()
      require('mkdnflow').setup({
        -- Config goes here; leave blank for defaults
      })
    end
  })
  use("renerocksai/calendar-vim") -- used by telekasten.vim
  use("renerocksai/telekasten.nvim")

	-- Colorschemes
	use({ "folke/tokyonight.nvim"})
	use({ "lunarvim/darkplus.nvim"})

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

  use { 'stevearc/aerial.nvim', config = function() require('aerial').setup() end } -- code outline sidebar

	-- IDE
  use { "williamboman/mason.nvim", branch = 'main' } -- exernal tools installer (lsp & dap servers among others)
    -- LSP
  use { "williamboman/mason-lspconfig.nvim" }
	-- use({ "williamboman/nvim-lsp-installer"}) -- simple to use language server installer
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
	use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
    -- DAP debugger
  use { "mfussenegger/nvim-dap" }
  use { "rcarriga/nvim-dap-ui" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
