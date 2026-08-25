return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  opt = {},
  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end,
}
