return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config["pyright"] = {}
      vim.lsp.config["ruff"] = {}
      
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}
