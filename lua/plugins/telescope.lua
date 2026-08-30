return {
  'nvim-telescope/telescope.nvim',
  -- 默认分支 master：已修复 make_position_params / supports_method 等新 nvim 兼容问题
  -- 懒加载：首次使用 Telescope 命令/LSP 跳转时才加载（节省启动 ~10ms）
  cmd = 'Telescope',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
      },
    })
  end,
}
