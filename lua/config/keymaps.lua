-- =====================================================================
-- Neovim 0.12.*
-- =====================================================================

-- q -> :noh
-- <leader>q -> record macro
vim.keymap.set({'n', 'v'}, "Q", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set({'n', 'v'}, "<leader>q", "q", { noremap = true, desc = "Record macro" })

-- M -> play macro
vim.keymap.set('n', 'M', '@', { noremap = true, desc = 'Play macro' })

-- R -> replacement
vim.keymap.set('n', 'R', ":%s//", { noremap = true, desc = "Replace search matches" })
-- partial replacements
vim.keymap.set('x', 'p', '"_dP', { desc = "Paste without overwriting register" })

-- line start, end navigation
-- H / L first/last valid char jump
vim.keymap.set({'n', 'v'}, 'H', '^',  { noremap = true, silent = true, desc = "Go to line start (non-whitespace)" })
vim.keymap.set({'n', 'v'}, 'L', 'g_', { noremap = true, silent = true, desc = "Go to line end (non-whitespace)" })
-- _ / g_ screen top/bottom jump
vim.keymap.set({'n', 'v'}, '_',  'H', { noremap = true, silent = true, desc = "Move to top of screen" })
vim.keymap.set({'n', 'v'}, 'g_', 'L', { noremap = true, silent = true, desc = "Move to bottom of screen" })

-- select all
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = "Select all" })

-- save
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = "Save current file" })

-- undo
vim.keymap.set('n', 'U', '<C-r>', { desc = "Redo" })

-- diagnostics auto fix
vim.keymap.set('n', 'S', vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Preview mode lives in lua/config/preview.lua
-- LSP keymaps live in lua/config/lsp.lua
