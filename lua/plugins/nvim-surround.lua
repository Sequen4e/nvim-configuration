return {
  "kylechui/nvim-surround",
  version = "*", -- 使用最新的 release 版本
  event = "VeryLazy", -- 延迟加载，不影响 Neovim 启动速度
  opt = {},
  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end,
}
