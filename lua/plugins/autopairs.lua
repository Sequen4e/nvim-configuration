return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      -- 1. 开启 Treesitter 智能校验（不在字符串/注释里误补全）
      check_ts = true,
      ts_config = {
        rust = { "string", "comment" },
      },

      -- 2. 自动跳过右括号（Overtype / Move Past）
      -- 当光标前面紧接着闭合符号时，再敲同一个闭合符号不重复输入，而是直接将光标移动到右边
      enable_moveright = true,

      -- 3. 智能退格（Backspace）
      -- 当你按 Backspace 时，如果光标在 (|) 中间，会自动同时删除一对括号
      enable_afterquote = true,
      map_bs = true,

      -- 4. 快速包裹 (FastWrap) - 极其强大的高级功能
      -- 在插入模式下按 Alt+e，可以快速把光标后的单词用括号包裹起来
      fast_wrap = {
        map = "<A-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%]%}%)%s]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- 5. 如果你使用了 nvim-cmp 自动补全插件，让补全函数名时自动带上 () 并把光标放中间
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if cmp_status_ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
