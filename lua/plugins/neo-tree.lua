return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 30,
      },
      close_if_last_window = false,
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true, -- 打开文件时，文件树自动定位到该文件
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle NeoTree" })
  end,
}
