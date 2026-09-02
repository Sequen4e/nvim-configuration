-- =====================================================================
-- LSP keymaps: telescope-based navigation, diagnostics and native floats
-- =====================================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    local telescope = require('telescope.builtin')

    -------------------------------------------------------------------
    -- 1. Telescope-based goto (definitions / references / ...)
    -------------------------------------------------------------------

    opts.desc = "LSP: [G]oto [D]efinition via Telescope"
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)

    opts.desc = "LSP: [G]oto [R]eferences via Telescope"
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)

    opts.desc = "LSP: [G]oto t[Y]pe Definition via Telescope"
    vim.keymap.set('n', 'gy', telescope.lsp_type_definitions, opts)

    opts.desc = "LSP: [G]oto [I]mplementation via Telescope"
    vim.keymap.set('n', 'gI', telescope.lsp_implementations, opts)

    opts.desc = "LSP: Search [D]ocument [S]ymbols"
    vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts)

    opts.desc = "LSP: Search [W]orkspace [S]ymbols"
    vim.keymap.set('n', '<leader>ws', telescope.lsp_workspace_symbols, opts)

    -------------------------------------------------------------------
    -- 2. Diagnostics
    -------------------------------------------------------------------

    opts.desc = "LSP: Workspace Diagnostics via Telescope"
    vim.keymap.set('n', '<leader>xx', telescope.diagnostics, opts)

    -------------------------------------------------------------------
    -- 3. Lightweight native floats
    -------------------------------------------------------------------

    opts.desc = "LSP: Hover Documentation"
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = "LSP: Show [G]o to [L]ine diagnostics"
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

    opts.desc = "LSP: [R]e[n]ame symbol"
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = "LSP: [C]ode [A]ction"
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
