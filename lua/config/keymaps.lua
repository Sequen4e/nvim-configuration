-- =====================================================================
-- Neovim 0.12.* + 
-- =====================================================================


--------------- Vanilla ---------------
---
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

-- `<->' checkout mark
vim.keymap.set({'n', 'v'}, "`", "'", { noremap = true, silent = true, desc = "Checkout mark with only row" })
vim.keymap.set({'n', 'v'}, "'", "`", { noremap = true, silent = true, desc = "Checkout mark with both row and col" })

-- S chord: quick insert
-- unset S
vim.keymap.set('n', 'S', '<Nop>', { silent = true })
-- insert pure empty line
vim.keymap.set('n', 'SJ', function()
    local count = vim.v.count1
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local empty_lines = {}
    for _ = 1, count do
        table.insert(empty_lines, "")
    end
    vim.api.nvim_buf_set_lines(0, row, row, false, empty_lines)
end, { silent = true, desc = "Insert blank line above" })
vim.keymap.set('n', 'SK', function()
    local count = vim.v.count1
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local empty_lines = {}
    for _ = 1, count do
        table.insert(empty_lines, "")
    end
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, empty_lines)
end, { silent = true, desc = "Insert blank line below" })
-- break line "\[n]"
vim.keymap.set('n', 'SS', function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local row, col = pos[1], pos[2]
    local line = vim.api.nvim_get_current_line()
    local char_under_cursor = line:sub(col + 1, col + 1)
    if char_under_cursor == " " or char_under_cursor == "\t" then
        vim.cmd('normal! r\r')
    else
        vim.cmd('normal! i\r')
    end
    vim.cmd('normal! k$')
end, { noremap = true, silent = true, desc = "Smart split line replacing space/tab with newline" })
vim.keymap.set('n', "SN", "a<CR><esc>k$", { noremap = true, silent = true, desc = "Break line after cursor" })
-- insert [Sp]ace
-- vim.keymap.set('n', "Sp", "i <esc>l", { noremap = true, silent = true, desc = "Insert space before cursor" })
-- vim.keymap.set('n', "SP", "a <esc>h", { noremap = true, silent = true, desc = "Insert space after cursor" })
-- insert tab(\t) [I]dentation
-- vim.keymap.set('n', "Si", "i    <esc>", { noremap = true, silent = true, desc = "Insert tab after cursor" })
-- insert '[<split symbol>]<space>'
-- vim.keymap.set('n', "S,", "i, <esc>hh", { noremap = true, silent = true, desc = "Insert a comma and a space after cursor" })

--------------- Vanilla ---------------


--------------- Plugins based ---------------

-- toggle markdown rendering
vim.keymap.set({'n', 'v'}, '<leader>mt', '<cmd>RenderMarkdown toggle<CR>', { desc = "Toggle markdown rendering" })

-- Embedded feature switch: when OFF, <leader>dd / :ArmDebug refuse to run.
-- Pure-software debugging (codelldb/debugpy via F5 etc.) is unaffected.
vim.g.embedded_enabled = true
vim.keymap.set('n', '<leader>td', function()
    vim.g.embedded_enabled = not vim.g.embedded_enabled
    vim.notify('Embedded: ' .. (vim.g.embedded_enabled and 'ENABLED' or 'DISABLED'), vim.log.levels.INFO)
end, { desc = 'Toggle embedded features' })

-- Preview mode lives in lua/config/preview.lua
-- LSP keymaps live in lua/config/lsp.lua

--------------- Plugins based ---------------
