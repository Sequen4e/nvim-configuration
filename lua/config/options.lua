-- hybrid linenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- Let Treesitter handle highlighting, not LSP semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- connect unamed register (*) and system clipboard (+)
vim.opt.clipboard = "unnamedplus"
-- visual mode copy to system clipboard
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- signcolumn constant persist
-- coexist on the same col: git marks (col 1), diagnostics (col 2)
vim.opt.signcolumn = "yes:2"

-- recogonize a sentence end with only 1 space
vim.opt.cpoptions:remove("J")

vim.opt.tabstop = 4        -- Tab 宽度为 4
vim.opt.shiftwidth = 4     -- 自动缩进宽度为 4
vim.opt.softtabstop = 4    -- 编辑时按 Tab 视作 4 个空格
vim.opt.expandtab = true   -- 按 Tab 时转换为实际空格
