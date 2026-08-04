return {
  'mrjones2014/smart-splits.nvim',
  lazy = false, -- 建议全局加载，以接管全局的窗口导航
  opts = {
    -- 当移动光标撞到 Neovim 边缘时的行为: 'wrap' (环绕) / 'at_edge' (停留在边缘) / nil
    ignored_events = {
      'BufEnter',
      'WinEnter',
    },
    -- 忽略控制窗口（如 Neo-tree）的无缝切换规则，避免意外抖动
    ignored_filetypes = {
      'nofile',
      'quickfix',
      'prompt',
    },
    -- 调整窗口大小时的步长（字符数/行数）
    resize_mode = {
      quit_key = '<ESC>',
      resize_keys = { 'h', 'j', 'k', 'l' },
      silent = true,
      hooks = {
        on_enter = nil,
        on_leave = nil,
      },
    },
  },
  config = function(_, opts)
    local ss = require('smart-splits')
    ss.setup(opts)

    -- ==================== 1. 方向键/hjkl 无缝切换窗口 ====================
    -- 相当于替代了原生的 <C-w>h, <C-w>j, <C-w>k, <C-w>l
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = "切到左侧窗口" })
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = "切到下方窗口" })
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = "切到上方窗口" })
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = "切到右侧窗口" })

    -- ==================== 2. Alt + hjkl 智能平滑拉伸窗口 ====================
    -- 按住 Alt + 对应方向，直接像拉手风琴一样平滑调整窗口大小
    vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = "向左拉伸/压缩" })
    vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = "向下拉伸/压缩" })
    vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = "向上拉伸/压缩" })
    vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = "向右拉伸/压缩" })

    -- ==================== 3. 窗口位置对调 (Swap Windows) ====================
    -- 如果想把当前的侧边栏/代码框和旁边的窗口互换位置：
    vim.keymap.set('n', '<leader>wh', ss.swap_buf_left, { desc = "当前窗口与左侧对调" })
    vim.keymap.set('n', '<leader>wj', ss.swap_buf_down, { desc = "当前窗口与下方对调" })
    vim.keymap.set('n', '<leader>wk', ss.swap_buf_up, { desc = "当前窗口与上方对调" })
    vim.keymap.set('n', '<leader>wl', ss.swap_buf_right, { desc = "当前窗口与右侧对调" })
  end,
}
