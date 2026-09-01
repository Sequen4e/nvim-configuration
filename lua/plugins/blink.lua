return {
  {
    "Saghen/blink.cmp",
    version = "1.*", -- 2026/8: v2 is destructive refactoring, pin version to v1
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
      -- master switch
      enabled = function()
        return vim.g.blink_cmp_enabled ~= false
      end,
      -- Tab = accept/next item, S-Tab = last item, Enter = accept selecting item
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
