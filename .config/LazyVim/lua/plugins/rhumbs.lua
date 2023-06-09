return {
  -- LazyVim enabled - conf overrides
  { "nvim-neo-tree/neo-tree.nvim", -- file explorer
    opts = {
      window = {
        mappings = {
          ["l"] = "open",
        }
      }
    },
  },
  { "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },

  -- Additionnal plugins
  { "moll/vim-bbye", -- close buffers without destroying windows
    keys = {
      { "<S-q>", "<cmd>Bdelete!<CR>" },
    }
  },
  { "numToStr/Navigator.nvim", -- navigate through tmux panes
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

  { "gpanders/editorconfig.nvim"}, -- follow formatting options of .editorconfig file
	{ "tpope/vim-fugitive"}, -- for Git blame
}
