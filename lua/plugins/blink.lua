return {
  {
    "Saghen/blink.cmp",
    version = "1.*", -- v1 稳定线（v2 破坏性变更中；官方建议 pin）
    event = "InsertEnter",
    keys = {
      {
        "<leader>tc",
        function()
          vim.g.blink_cmp_enabled = not (vim.g.blink_cmp_enabled ~= false)
          vim.notify(
            "Auto Completion:" .. (vim.g.blink_cmp_enabled and "ON" or "OFF"),
            vim.log.levels.INFO
          )
        end,
        desc = "Toggle completion",
      },
    },
    opts = {
      -- 补全总开关：每次触发时求值，<leader>tc 翻转 vim.g.blink_cmp_enabled 即生效
      enabled = function()
        return vim.g.blink_cmp_enabled ~= false
      end,
      -- Tab = 接受/下一项，S-Tab = 上一项，Enter = 接受选中
      keymap = { preset = "super-tab" },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
        menu = {
          border = "rounded",
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
      },
      signature = { enabled = true },
    },
  },
}
