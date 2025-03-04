-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "JK", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "KJ", "<ESC>", opts)

-- Reset keymaps
-- vim.keymap.del({'n', 'v'}, 'S')

-- Edit LazyVim config
keymap("n", "<leader>se", ":e $MYVIMRC<RETURN>", { silent = true, desc = "configuration" })

-- Show messages & errors history
keymap("n", "<leader>sm", ":Telescope notify", { silent = true, desc = "Messages history" })

-- references
keymap("n", "<leader>j", "<Cmd>Trouble lsp toggle<CR>", { silent = true, desc = "LSP definitions, references, ..." })

-- doge
keymap("n", "<Leader>ch", "<Plug>(doge-generate)")
-- Interactive mode comment todo-jumping.
keymap("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
keymap("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
keymap("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
keymap("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
keymap("s", "<TAB>", "<Plug>(doge-comment-jump-forward)")
keymap("s", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
