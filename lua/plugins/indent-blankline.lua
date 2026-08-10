return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    -- 1. 基础缩进线外观样式
    indent = {
      char = "┊", -- 缩进线字符，可选："│", "┆", "┊", "┊"
      tab_char = "┊",
    },

    -- 2. 当前跨行作用域（Scope/成对符号）高亮设置
    scope = {
      enabled = true, -- 开启当前成对符号/作用域高亮
      show_start = true, -- 在跨行代码块的开始行画一条水平指示线
      show_end = true, -- 在跨行代码块的结束行画一条水平指示线
      injected_languages = false,
      highlight = { "Function", "Label" }, -- 使用的色彩高亮组
      priority = 1024,
      char = "│", -- 当前激活的跨行连接线样式（可设为粗线或不同线条）
    },

    -- 3. 排除不需要显示缩进线的文件类型
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  },
}
