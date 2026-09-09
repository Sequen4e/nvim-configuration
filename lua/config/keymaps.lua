-- =====================================================================
-- Neovim 0.12.*
-- =====================================================================

-- q -> preview mode (detailed in preview.lua)
-- Q -> record macro
vim.keymap.set({'n', 'v'}, "Q", "q", { noremap = true, desc = "Record macro" })

-- Z -> :noh
vim.keymap.set({'n', 'v'}, "Z", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

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

-- undo
vim.keymap.set('n', 'U', '<C-r>', { desc = "Redo" })

-- S: Refactor, Git & Diagnostics
-- unset S
vim.keymap.set('n', 'S', '<Nop>', { silent = true })
-- Refactor (S)
vim.keymap.set('n', 'Sr', function() vim.lsp.buf.rename() end, { desc = "LSP: Rename symbol" })
vim.keymap.set('n', 'Sf', function() vim.lsp.buf.format({ async = true }) end, { desc = "LSP: Format buffer" })
vim.keymap.set('n', 'Sa', function() vim.lsp.buf.code_action() end, { desc = "LSP: Code action" })
-- Git (Sh)
vim.keymap.set('n', 'Shs', '<cmd>Gitsigns stage_hunk<CR>', { desc = "Git: Stage hunk" })
vim.keymap.set('n', 'Shr', '<cmd>Gitsigns reset_hunk<CR>', { desc = "Git: Reset hunk" })
vim.keymap.set('n', 'Shb', '<cmd>Gitsigns blame_line<CR>', { desc = "Git: Blame line" })
vim.keymap.set('n', 'Shp', '<cmd>Gitsigns preview_hunk<CR>', { desc = "Git: Preview hunk" })
vim.keymap.set('n', 'Shd', '<cmd>Gitsigns diffthis<CR>', { desc = "Git: Diff this" })
-- Diagnostic (Sc)
vim.keymap.set('n', 'Scq', function() vim.diagnostic.setloclist() end, { desc = "LSP: Quickfix diagnostics" })
vim.keymap.set('n', 'Sn', function() vim.diagnostic.goto_next() end, { desc = "LSP: Next diagnostic" })
vim.keymap.set('n', 'SN', function() vim.diagnostic.goto_prev() end, { desc = "LSP: Prev diagnostic" })

-- Embedded feature switch: when OFF, <leader>dd / :ArmDebug refuse to run.
-- Pure-software debugging (codelldb/debugpy via F5 etc.) is unaffected.
vim.g.embedded_enabled = true
vim.keymap.set('n', '<leader>td', function()
    vim.g.embedded_enabled = not vim.g.embedded_enabled
    vim.notify('Embedded: ' .. (vim.g.embedded_enabled and 'ENABLED' or 'DISABLED'), vim.log.levels.INFO)
end, { desc = 'Toggle embedded features' })

-- Preview mode lives in lua/config/preview.lua
-- LSP keymaps live in lua/config/lsp.lua
