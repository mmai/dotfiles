local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>AerialToggle!<cr>", "Aerial code outline" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeOpen<cr>", "Explorer" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["z"] = { ":ZenMode<cr>", "Zen mode" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
  },

  d = {
    name = "DAP debugger",
    b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint"},
    c = {"<cmd>lua require'dap'.continue()<cr>", "Continue"},
    i = {"<cmd>lua require'dap'.step_into()<cr>", "Step into"},
    o = {"<cmd>lua require'dap'.step_over()<cr>", "Step over"},
    O = {"<cmd>lua require'dap'.step_out()<cr>", "Step out"},
    r = {"<cmd>lua require'dap'.repl.toggle()<cr>", "Repl toggle"},
    l = {"<cmd>lua require'dap'.run_last()<cr>", "Run last"},
    u = {"<cmd>lua require'dapui'.toggle()<cr>", "UI toggle"},
    t = {"<cmd>lua require'dap'.terminate()<cr>", "Terminate"},
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    e = { "<cmd>Telescope symbols<cr>", "Emojis" },
  },

  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle"},
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics"},
    e = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
    d = { "<cmd>TroubleToggle lsp_definitions<cr>", "LSP definitions" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP references" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  w = {
    name = "Wiki (Telekasten)",
    p = { "<cmd>lua require('telekasten').panel()<cr>", "Panel" },
    f = { "<cmd>lua require('telekasten').find_notes()<cr>", "Find notes" },
    d = { "<cmd>lua require('telekasten').find_daily_notes()<cr>", "Find daily notes" },
    g = { "<cmd>lua require('telekasten').search_notes()<cr>", "Search in notes" },
    t = { "<cmd>lua require('telekasten').show_tags()<cr>", "Search through tags" },
    l = { "<cmd>lua require('telekasten').follow_link()<cr>", "Follow link" },
    L = { "<cmd>lua require('telekasten').insert_link()<cr>", "Insert a link to a note" },
    w = { "<cmd>lua require('telekasten').goto_today()<cr>", "Open today's daily note" },
    W = { "<cmd>lua require('telekasten').goto_thisweek()<cr>", "Open weekly note" },
    n = { "<cmd>lua require('telekasten').new_note()<cr>", "Create a new note" },
    N = { "<cmd>lua require('telekasten').new_templated_note()<cr>", "Create a new note from a template" },
    y = { "<cmd>lua require('telekasten').yank_notelink()<cr>", "Yank a link to the currently open note" },
    c = { "<cmd>lua require('telekasten').show_calendar()<cr>", "Show the calendar" },
    C = { ":CalendarT<cr>", "Big calendar" },
    v = { "<cmd>lua require('telekasten').preview_img()<cr>", "Preview image under cursor" },
    I = { "<cmd>lua require('telekasten').paste_img_and_link()<cr>", "Paste an image from the clipboard" },
    i = { "<cmd>lua require('telekasten').insert_img_link()<cr>", "Browse images and insert a link to the selected one" },
    r = { "<cmd>lua require('telekasten').rename_note()<cr>", "Rename current note and update links" },
    b = { "<cmd>lua require('telekasten').show_backlinks()<cr>", "Show all notes linking to the current one" },
    B = { "<cmd>lua require('telekasten').find_friends()<cr>", "Show all notes linking to the link under cursor" },
    m = { "<cmd>lua require('telekasten').browse_media()<cr>", "Browse medias" },
  },
  r = {
    name = "Refactor",
    b = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract Block" },
    bf = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract Block to file" },
    i = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline variable" },
  }
}

local visual_mappings = {
  r = {
    name = "Refactor",
    e = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
    f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "Extract Function To File" },
    v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable To File')<CR>", "Extract Variable To File" },
    i = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
  -- prompt for a refactor to apply when the remap is triggered
    r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Choose refactor" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(visual_mappings, visual_opts)
