require "user.impatient"
require "user.plugins"

require "user.options"
require "user.autocommands"
require "user.colorscheme"

require "user.keymaps"
require "user.whichkey"

-- UI
require "user.alpha"      -- welcome screen
require "user.nvim-tree"  -- file browser sidebar
require "user.bufferline" -- tab line
require "user.lualine"    -- status line
require "user.toggleterm" -- open terminal
require "user.telescope"  -- highly customizable fzf like picker

require "user.gitsigns"

-- Coding
require "user.autopairs"
require "user.comment"
require "user.indentline"

-- IDE
require("mason").setup()          -- lsp & dap languages installer
require('refactoring').setup({})  -- extract function, extract variable, ...
require "user.project"            -- detect project root
require "user.treesitter"         -- syntax tree analyser (used by other coding plugins)
require "user.aerial"             -- list & navigate in classes & functions
require "user.cmp"                -- completion
require "user.lsp"                -- language server
require "user.dap"                -- debugger (breakpoints & co)

require "user.telekasten"         -- wiki / zetelkasten
