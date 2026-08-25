return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- 显式指定 master 分支，防止被主分支重构影响
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- 延迟按需加载，提升启动速度
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    configs.setup({
      ensure_installed = { "rust", "lua", "vim", "vimdoc", "python", "c", "cpp", "bash", "markdown", "markdown_inline", "latex", "bibtex" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end,
}
