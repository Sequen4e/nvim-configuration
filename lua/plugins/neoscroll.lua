return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")

    -- initializing neoscroll engin
    neoscroll.setup({
      mappings = {}, -- disable default key mappings
      hide_cursor = false,
      stop_eof = true, -- 边界平滑停止
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "quadratic", -- 物理平滑缓动
    })

    -- pre-defined smooth scroll
    local function scroll_half_down()
      neoscroll.scroll(0.5, { move_cursor = false, duration = 200 })
    end
    local function scroll_half_up()
      neoscroll.scroll(-0.5, { move_cursor = false, duration = 200 })
    end
    local function scroll_down()
      neoscroll.ctrl_f({ duration = 250, cursor = false })
    end
    local function scroll_up()
      neoscroll.ctrl_b({ duration = 250, cursor = false })
    end

    -- key mappings
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    -- [default]
    keymap("n", "<C-u>", scroll_half_up,   vim.tbl_extend("force", opts, { desc = "up scroll half page" }))
    keymap("n", "<C-d>", scroll_half_down, vim.tbl_extend("force", opts, { desc = "down scroll half page" }))
    keymap("n", "<C-f>", scroll_down,   vim.tbl_extend("force", opts, { desc = "up scroll page" }))
    keymap("n", "<C-b>", scroll_up, vim.tbl_extend("force", opts, { desc = "down scroll page" }))
  end,
}
