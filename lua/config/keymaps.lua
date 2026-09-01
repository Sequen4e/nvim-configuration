-- =====================================================================
-- Neovim 0.12.*
-- =====================================================================

-- q -> :noh
-- <leader>q -> macro recording
vim.keymap.set("n", "q", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", "q", { noremap = true, desc = "Record macro" })

-- S: replacement
vim.keymap.set("n", "gS", ":%s//", { noremap = true, desc = "Replace search matches" })

-- partial replacements
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without overwriting register" })

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

-- LSP-based servic config
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    local telescope = require('telescope.builtin')

    -------------------------------------------------------------------
    -- 1. 基于 Telescope 的核心跳转与搜索 (Go to...)
    -------------------------------------------------------------------
    
    -- gd: 用 Telescope 弹窗跳转定义（如果只有 1 个定义会自动直接跳过，多个则弹窗选择）
    opts.desc = "LSP: [G]oto [D]efinition via Telescope"
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)

    -- gr: 查找全项目所有引用 (References) 并提供实时预览
    opts.desc = "LSP: [G]oto [R]eferences via Telescope"
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)

    -- gy: 跳转到类型定义 (Type Definition)
    opts.desc = "LSP: [G]oto t[Y]pe Definition via Telescope"
    vim.keymap.set('n', 'gy', telescope.lsp_type_definitions, opts)

    -- gI: 跳转到接口 / Trait 的具体实现 (Implementation)
    opts.desc = "LSP: [G]oto [I]mplementation via Telescope"
    vim.keymap.set('n', 'gI', telescope.lsp_implementations, opts)

    -- <leader>ds: 搜索当前文件中的所有符号 (Document Symbols, 函数/结构体/变量)
    opts.desc = "LSP: Search [D]ocument [S]ymbols"
    vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts)

    -- <leader>ws: 搜索全项目的符号 (Workspace Symbols)
    opts.desc = "LSP: Search [W]orkspace [S]ymbols"
    vim.keymap.set('n', '<leader>ws', telescope.lsp_workspace_symbols, opts)

    -------------------------------------------------------------------
    -- 2. 基于 Telescope 的全局诊断报错查看 (Diagnostics)
    -------------------------------------------------------------------
    
    -- <leader>xx: 弹窗列出全项目（或当前文件）所有的语法错误与警告
    opts.desc = "LSP: Workspace Diagnostics via Telescope"
    vim.keymap.set('n', '<leader>xx', telescope.diagnostics, opts)

    -------------------------------------------------------------------
    -- 3. 保留轻量的原生浮动窗口动作 (不需要 Telescope 弹窗的微操)
    -------------------------------------------------------------------
    
    -- K: 悬浮查看当前符号的文档/类型签名
    opts.desc = "LSP: Hover Documentation"
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- gl: 浮动窗口查看当前行的诊断报错
    opts.desc = "LSP: Show [G]o to [L]ine diagnostics"
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

    -- <leader>rn: 变量重命名 (Rename)
    opts.desc = "LSP: [R]e[n]ame symbol"
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- <leader>ca: 代码重构/修复建议 (Code Action)
    opts.desc = "LSP: [C]ode [A]ction"
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

  end,
})
