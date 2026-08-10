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
      close_if_last_window = false,
      filesystem = {
        filtered_items = {
          visible = true,
	  hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        position = "left",
        width = 30,
      },
      window = {
	mappings = {
	  -- -----------------------------------------------------------
          -- [需求 1] 树内高效导航（父节点、首尾快速跳转）
          -- -----------------------------------------------------------
          ["p"] = "navigate_up", -- 跳转到父节点 (Parent)
          ["]"] = "next_sibling", -- 跳转到同层级的下一个文件/文件夹
          ["["] = "prev_sibling", -- 跳转到同层级的上一个文件/文件夹
          ["J"] = "last_sibling", -- 快速跳转到同层级的【最后一个】
          ["K"] = "first_sibling", -- 快速跳转到同层级的【第一个】

          -- -----------------------------------------------------------
          -- [需求 2] 局限于 Neo-tree 树内的搜寻/过滤（不会切到其他窗口）
          -- -----------------------------------------------------------
          ["/"] = "fuzzy_finder", -- 模糊搜索过滤（只在 neo-tree 树内，实时高亮匹配）
          ["f"] = "filter_on_submit", -- 按 Enter 确认搜索过滤内容

          -- -----------------------------------------------------------
          -- [需求 3] 全部折叠 / 全部展开
          -- -----------------------------------------------------------
          ["zM"] = "close_all_nodes", -- 全部折叠
          ["zR"] = "expand_all_nodes", -- 全部展开

          -- -----------------------------------------------------------
          -- [需求 4] 临时改变工作区根目录
          -- -----------------------------------------------------------
          ["."] = "set_root", -- 将光标下的文件夹设为临时根目录 (Change Root)
          ["u"] = "navigate_up", -- 向上返回上一层根目录
          ["C"] = "set_root", -- 兼容习惯：C 也设为根目录
	}
      },
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle left<CR>", { desc = "Toggle NeoTree" })
  end,
}
