-- vim.opt.number = true
vim.opt.relativenumber = true

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.lsp")

-- Let Treesitter handle highlighting, not LSP semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
