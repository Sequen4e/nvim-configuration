return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")

    -- 1. 初始化 neoscroll 引擎
    neoscroll.setup({
      mappings = {}, -- 彻底禁用默认的 Ctrl 键位映射
      hide_cursor = true, -- 滚动时隐藏光标
      stop_eof = true, -- 边界平滑停止
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "quadratic", -- 物理平滑缓动
    })

    -- 2. 预定义平滑滚动 API (半页 200ms / 整页 250ms)
    local function scroll_half_down()
      neoscroll.scroll(0.5, true, 200)
    end
    local function scroll_half_up()
      neoscroll.scroll(-0.5, true, 200)
    end

    -- 3. 按键映射预留区（后续确定键位后，取消对应注释即可）
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- 【方案 A】：方括号 [ (上翻) 与 ] (下翻)
    -- keymap("n", "]", scroll_half_down, vim.tbl_extend("force", opts, { desc = "向下平滑翻半页" }))
    -- keymap("n", "[", scroll_half_up,   vim.tbl_extend("force", opts, { desc = "向上平滑翻半页" }))

    -- 【方案 B】：大写 H (上翻) 与 L (下翻)
    -- keymap("n", "L", scroll_half_down, vim.tbl_extend("force", opts, { desc = "向下平滑翻半页" }))
    -- keymap("n", "H", scroll_half_up,   vim.tbl_extend("force", opts, { desc = "向上平滑翻半页" }))

    -- 【方案 C】：Leader 组合键 <leader>j / <leader>k
    -- keymap("n", "<leader>j", scroll_half_down, vim.tbl_extend("force", opts, { desc = "向下平滑翻半页" }))
    -- keymap("n", "<leader>k", scroll_half_up,   vim.tbl_extend("force", opts, { desc = "向上平滑翻半页" }))
  end,
}
