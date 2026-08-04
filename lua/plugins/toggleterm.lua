return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- 明确指定触发键或在打开时加载
  keys = {
    { "<C-t>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Terminal Horizontal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-t>]], -- 改用 Ctrl+t 避免键盘转义冲突
      direction = "horizontal",
      shade_terminals = true,
      persist_size = true,
      close_on_exit = true,
    })

    -- 终端模式快捷键绑定：方便在终端和代码区之间跳转
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- 在终端内部按 Esc Esc 退出终端输入模式，回到 Normal 模式
      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
      -- 方便从终端直接切回上方代码区
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })
  end,
}
