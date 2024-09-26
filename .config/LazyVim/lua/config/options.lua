-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.wrap = true
opt.spelllang = { "en", "fr" }

opt.commentstring = "# %s"

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
-- vim.g.lazyvim_php_lsp = "intelephense"
