return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              -- 新版 rust-analyzer 不再接受 checkOnSave 映射形式:
              -- clippy 检查移至 check.command,checkOnSave 改为布尔值(行为与原先一致:保存时跑 clippy)
              check = { command = "clippy" },
              checkOnSave = true,
            },
          },
        },
      }
    end,
  },
}
