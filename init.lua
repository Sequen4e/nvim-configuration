-- vim.opt.number = true
vim.opt.relativenumber = true

require("config.lazy")

require("config.keymaps")

require("config.options")

-- 统一全局规则：让 LSP 只负责“补全和跳转”，把“彩色高亮”完全交给 Treesitter
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
