-- =====================================================================
-- Neovim 0.12.0 + Telescope + LSP 最佳绑定配置
-- =====================================================================

-- 宏录制重绑定：q 让位给清除搜索高亮，录制改由 <leader>q 触发
-- 注意 noremap：rhs 的 "q" 必须直通内建命令，否则会递归触发上面的 noh 映射
vim.keymap.set("n", "q", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", "q", { noremap = true, desc = "Record macro" })

-- S 替代 cc：将当前 buffer 中所有搜索高亮的文本替换为接下来输入的内容
-- 用法：/foo<CR> 高亮全部匹配 → S → 输入 bar/g<CR>（全量）或 bar/gc<CR>（逐个确认）
-- （:%s 的 pattern 留空 = 复用上次搜索，即当前高亮内容）
vim.keymap.set("n", "S", ":%s//", { noremap = true, desc = "Replace search matches" })

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

    -- forbbid "d" override clip board
    vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
  end,
})
