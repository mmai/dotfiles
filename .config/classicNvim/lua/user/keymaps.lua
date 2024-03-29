-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Command --
vim.cmd [[
  " Expand %% to path of current buffer in command mode.
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]]

-- Normal --

-- Easy vimrc editing
keymap("n", "<localleader>e", ":e $MYVIMRC<CR>", opts)
keymap("n", "<localleader>s", ":luafile $MYVIMRC<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "JK", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("i", "KJ", "<ESC>", opts)

-- Allow easy navigation between wrapped lines.
keymap("v", "j", "gj", opts)
keymap("v", "k", "gk", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --
-- dial ( better increment)
keymap("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
keymap("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
keymap("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
keymap("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})

-- Hop (on my qwerty with dead keys : double ´'´)
keymap('n', '´', "<cmd>HopChar2<cr>", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeOpen<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Refactoring ( mappings redefined in whichkey.lua )
local refactOpts = {noremap = true, silent = true, expr = false}
  -- Remaps for the refactoring operations currently offered by the plugin
keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], refactOpts)
keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], refactOpts)
keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], refactOpts)
keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], refactOpts)
  -- Extract block doesn't need visual mode
keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], refactOpts)
keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], refactOpts)
  -- Inline variable can also pick up the identifier currently under the cursor without visual mode
keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], refactOpts)
  -- prompt for a refactor to apply when the remap is triggered
keymap( "v", "<leader>rr","<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })
  -- print / clean debugs statements
keymap("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
keymap("n", "<leader>rp", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", { noremap = true })
keymap("n", "<leader>rd", ":lua require('refactoring').debug.printf({below = false})<CR>", { noremap = true })
keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

-- DAP ( mappings redefined in whichkey.lua )
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Zen mode
keymap("n", "<leader>z", ":ZenMode<CR>", opts)

-------------------- Refresh config -----------
-- keymap("n", ",<leader>R", ":LuaCacheClear<CR>:luafile <CR>:PackerCompile<CR>", opts)

--------------- Personal wiki ----------------
-- , + Enter : open markdown wiki links in a new split
keymap("n", ",<CR>", "<C-w>v:MdwiGotoLink<CR>", opts)
-- Go back in history
keymap("n", ",,", ":BufSurfBack<CR>", opts)
-- Go forward in history
keymap("n", ",;", ":BufSurfForward<CR>", opts)
-- When cursor is on a command between backtics, execute it (ex: `tmuxp load -y myproject`)
keymap("n", "gt", "yi`:!<C-r>\"<CR>", opts)
