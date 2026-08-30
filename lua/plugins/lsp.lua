-- ============================================================
-- 添加新语言的框架约定（三步）：
--   1. mason.lua 的 ensure_installed 里加入对应 LSP 二进制
--   2. 下方 config 里 vim.lsp.config["<server>"] = { cmd = { mason 绝对路径, ... } }
--      + vim.lsp.enable("<server>")
--   3. (可选) conform 的 formatters_by_ft 加格式化器
-- 铁律：同一插件的 spec 不得拆分到多个文件（lazy 只执行一个 config），
-- 所有 LSP/conform 配置必须集中在本文件
-- ============================================================
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
