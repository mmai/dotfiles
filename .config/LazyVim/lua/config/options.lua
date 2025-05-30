-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.wrap = true
opt.relativenumber = false
opt.spelllang = { "en", "fr" }

opt.commentstring = "# %s"

-- disable default mappings for doge
vim.g.doge_enable_mappings = 0

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
-- vim.g.lazyvim_php_lsp = "intelephense"
