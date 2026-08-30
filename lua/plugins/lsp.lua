-- telescope 0.1.x 调用 make_position_params 时未传 position_encoding
-- （nvim 0.11+ 会在跨文件跳转时告警）；统一补默认 utf-16（LSP 标准编码，
-- clangd/pyright/rust-analyzer 均默认 utf-16），消除告警且行为不变
local lsp_util = require("vim.lsp.util")
local orig_make_position_params = lsp_util.make_position_params
lsp_util.make_position_params = function(win, encoding)
  return orig_make_position_params(win, encoding or "utf-16")
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 注意：同一插件在多个 spec 文件里声明时，lazy 只会执行其中一个 config
      -- （按文件名排序后者覆盖前者），因此所有 LSP 配置必须集中在本文件
      -- 另外 mason 是 cmd 懒加载，其 bin 目录不会注入 PATH，cmd 必须写绝对路径

      vim.lsp.config["clangd"] = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/clangd", "--background-index", "--header-insertion=never" },
        filetypes = { "c", "cpp", "h", "hpp" },
      }
      vim.lsp.enable("clangd")

      vim.lsp.config["pyright"] = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
      }
      vim.lsp.enable("pyright")

      vim.lsp.config["ruff"] = {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/ruff", "server" },
      }
      vim.lsp.enable("ruff")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        python = { "ruff_format" },
      },
    },
  },
}
