return {
  ------------------------------------------
  -- Disable some plugins
  ------------------------------------------
  { "RRethy/vim-illuminate", enabled = false }, -- automatically highlight other uses of the word under the cursor
 
  ------------------------------------------
  -- LazyVim enabled - conf overrides
  ------------------------------------------
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
  { "echasnovski/mini.bufremove",
    keys = {
      { "<S-q>",  function() require("mini.bufremove").delete(0, false) end }, -- ajout shortcut
    },
  },

  ------------------------------------------
  -- Additionnal plugins
  ------------------------------------------
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

  { "mmai/vim-markdown-wiki", -- eases the navigation between files in a personnal wiki based on markdown
    lazy = false,
    ft = {"markdown"},
    keys = {
      {",<CR>", "<C-w>v:MdwiGotoLink<CR>", opts}
    }
  },
  { "gpanders/editorconfig.nvim"}, -- follow formatting options of .editorconfig file
	{ "tpope/vim-fugitive", -- for Git blame
    keys = {
      { "<leader>gb", ":Git blame<CR>", desc = "git blame" },
    }
  },
}
