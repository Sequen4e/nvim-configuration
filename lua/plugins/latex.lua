return {
  {
    "lervag/vimtex",
    version = "v2.18", -- 最新 master 要求 nvim>=0.12.4,当前 0.12.0-dev 需 pin 最新 release(v2.18 要求 >=0.10)
    lazy = false, -- VimTeX 自带 ftdetect (tex_flavor 检测)，不建议按需加载
    init = function()
      -- zathura 支持 synctex 正反向搜索；未安装时回退到 VimTeX 自动检测
      if vim.fn.executable("zathura") == 1 then
        vim.g.vimtex_view_method = "zathura"
      end
    end,
  },
}
