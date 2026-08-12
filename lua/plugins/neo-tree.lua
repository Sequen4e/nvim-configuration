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
      close_if_last_window = true,

      -- 1. 窗口样式与全局按键映射（直接写在 window 下）
      window = {
        position = "left",
        width = 25, -- 调整为 25 避免路径较长时挤压
        mappings = {
          -- 同层级跳转
          -- ["]"] = "next_sibling",     -- 跳转到同层级的下一个文件/文件夹
          -- ["["] = "prev_sibling",     -- 跳转到同层级的上一个文件/文件夹
          -- ["J"] = "last_sibling",     -- 快速跳转到同层级的【最后一个】
          -- ["K"] = "first_sibling",    -- 快速跳转到同层级的【第一个】

          -- 树内过滤搜索
          ["/"] = "fuzzy_finder",     -- 模糊搜索过滤（只在 neo-tree 树内，实时高亮匹配）
          ["f"] = "filter_on_submit", -- 按 Enter 确认搜索过滤内容

          -- 全部折叠与展开
          ["zM"] = "close_all_nodes",  -- 全部折叠
          ["zR"] = "expand_all_nodes", -- 全部展开

          -- 临时改变根目录
          ["."] = "set_root",         -- 将光标下的文件夹设为临时根目录
          ["u"] = "navigate_up",       -- 向上返回上一层根目录
          -- ["C"] = "set_root",         -- 兼容习惯：C 也设为根目录
        },
      },

      -- 2. 文件系统特有设置
      filesystem = {
        filtered_items = {
          visible = true,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
    })

    -- 绑定快捷键唤出 neo-tree
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle NeoTree" })
  end,
}
